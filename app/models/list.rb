class List
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Slug
  include Tire::Model::Search

  belongs_to :user, touch: true
  has_many :reports
  embeds_many :items, cascade_callbacks: true
  embeds_many :comments, cascade_callbacks: true
  validates_presence_of :title, :category_id
  validates_numericality_of :category_id, greater_than_or_equal_to: 0, less_than: ListCategories.length
  validates_length_of :description, maximum: 900, allow_blank: true
  # TODO validate that there is at least one item
  accepts_nested_attributes_for :items
  after_save :check_search_index
  default_scope where(deleted_at: nil)

  slug :title, history: true, reserve: ListForbiddenNames

  field :title,       type: String
  field :deleted_at,  type: Time
  field :category_id, type: Integer
  field :description, type: String
  field :lovers,      type: Array, default: []
  field :loves,       type: Integer

  settings TireListSettings do
    mapping do
      indexes :slug,        type: 'string', index: :no
      indexes :user_id,     type: 'string', as: 'user_id.to_s'
      indexes :user_login,  type: 'string', as: 'user.login', analyzer: 'full_login', boost: 20
      indexes :category_id, type: 'integer'
      indexes :loves,       type: 'integer'
      indexes :items,       type: 'integer', as: 'items.size'
      indexes :comments,    type: 'integer', as: 'comments.size'
      indexes :created_at,  type: 'date'
      indexes :title,       type: 'multi_field', fields: {
        title:   { type: 'string', analyzer: 'full_title', boost: 100 },
        partial: { type: 'string', search_analyzer: 'full_title', index_analyzer: 'partial_title', boost: 50 }}
    end
  end

  def self.search params, page=0
    params.select! {|k, v| ['query', 'category_id', 'user_id', 'user_ids', 'starts_at', 'ends_at'].include?(k) && !v.blank? }
    tire.search({page: page, per_page: 12, load: true}) do
      query { string(params['query'], default_operator: "OR", fields: List.search_fields) } unless params['query'].blank?
      filter(:and, List.search_filters(params)) unless params.except('query').size == 0
      sort { by :_score, 'desc' }
    end
  end

  def self.search_filters params
    filters = []
    filters << {term:  {category_id: params['category_id'].to_i}} unless params['category_id'].blank?
    filters << {term:  {user_id: params['user_id']}} unless params['user_id'].blank?
    filters << {terms: {user_id: params['user_ids']}} unless params['user_ids'].blank?
    filters << {range: {created_at: {from: params['starts_at'], to: params['ends_at']}}} unless params['starts_at'].blank? && params['ends_at'].blank?
    filters
  end

  def self.search_fields
    [:title, 'title.partial', :user_login]
  end

  def soft_delete
    update_attribute(:deleted_at, Time.current)
  end

  def category_name
    ListCategories.at(category_id)[0]
  end

  def items_ordered
    items.sort_by(&:position)
  end

private

  def check_search_index
    if deleted_at.nil? && !user_id.nil?
      self.index.store self
    else
      self.index.remove self
    end
  end
end
