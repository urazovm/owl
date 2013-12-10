class Report

  include Mongoid::Document
  include Mongoid::Timestamps::Created

  belongs_to :list
  validates_presence_of :ip
  accepts_nested_attributes_for :list

  field :message, type: Boolean
  field :ip, type: String
end
