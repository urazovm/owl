class Item
  include Mongoid::Document
  include Mongoid::Timestamps

  embedded_in :list
  validates_presence_of :name
  validates_length_of :name, maximum: 100

  field :name, type: String
end
