class Comment
  include Mongoid::Document
  include Mongoid::Timestamps

  belongs_to :user
  embedded_in :list
  validates_presence_of :message, :user_id
  validates_length_of :message, maximum: 500

  field :message, type: String
end
