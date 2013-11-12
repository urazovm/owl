class List
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Slug

  belongs_to :user
  validates_presence_of :title, :category_id
  validates_numericality_of :category_id, greater_than_or_equal_to: 0, less_than: ListCategories.length
  default_scope where(deleted_at: nil)

  slug :title, history: true, reserve: ListForbiddenNames

  field :title,       type: String
  field :deleted_at,  type: Time
  field :category_id, type: Integer

  def soft_delete
    update_attribute(:deleted_at, Time.current)
  end
end
