class List
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Slug

  belongs_to :user
  validates_presence_of :title
  default_scope where(deleted_at: nil)

  slug :title, history: true, reserve: ListForbiddenNames

  field :title,       type: String
  field :deleted_at,  type: Time

  def soft_delete
    update_attribute(:deleted_at, Time.current)
  end
end
