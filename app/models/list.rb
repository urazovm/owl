class List
  include Mongoid::Document
  include Mongoid::Timestamps

  belongs_to :user
  validates_presence_of :title

  field :title, type: String
end
