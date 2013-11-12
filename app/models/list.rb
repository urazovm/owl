class List
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Slug

  belongs_to :user
  validates_presence_of :title

  slug :title, history: true, reserve: ListForbiddenNames

  field :title, type: String
end
