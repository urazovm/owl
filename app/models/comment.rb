class Comment
  include Mongoid::Document
  include Mongoid::Timestamps

  embedded_in :list
  validates_presence_of :message, :user_id
  validates_length_of :message, maximum: 500

  field :message, type: String
  field :user_id, type: String

  def user
    User.find(user_id)
  end

  def user= user
    self.user_id = user.id
  end
end
