class List
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Slug

  belongs_to :user
  embeds_many :items
  validates_presence_of :title, :category_id
  validates_numericality_of :category_id, greater_than_or_equal_to: 0, less_than: ListCategories.length
  validates_length_of :description, maximum: 900, allow_blank: true
  default_scope where(deleted_at: nil)
  accepts_nested_attributes_for :items

  slug :title, history: true, reserve: ListForbiddenNames

  field :title,       type: String
  field :deleted_at,  type: Time
  field :category_id, type: Integer
  field :description, type: String

  def soft_delete
    update_attribute(:deleted_at, Time.current)
  end

  def category_name
    ListCategories.at(category_id)[0]
  end
end
