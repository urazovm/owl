class Item
  include Mongoid::Document
  include Mongoid::Timestamps

  embedded_in :list
  validates_length_of :name, maximum: 100, allow_blank: true

  field :name, type: String
end
