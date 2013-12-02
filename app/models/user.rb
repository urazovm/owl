class User
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Slug
  include Mongoid::Paperclip

  has_many :lists
  validates_presence_of :login
  validates_uniqueness_of :login

  slug :login, history: false

  # TODO see if devise actions are cachable ?
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_mongoid_attached_file :avatar,
    default_url: '/assets/avatar/:style.jpg',
    styles: {
      small:    ['48x48#',   :jpg],
      medium:   ['128x128#', :jpg],
      large:    ['250x250#', :jpg] }
  validates_attachment_size :avatar, less_than: 800.kilobytes
  validates_attachment_content_type :avatar, content_type: ['image/jpeg', 'image/png', 'image/gif']

  field :email,                  type: String, default: ''
  field :login,                  type: String
  field :lovings,                type: Array,  default: []
  field :followings,             type: Array,  default: []
  field :followers,              type: Array,  default: []
  field :encrypted_password,     type: String, default: ''
  field :reset_password_token,   type: String
  field :reset_password_sent_at, type: Time
  field :remember_created_at,    type: Time
  field :sign_in_count,          type: Integer, default: 0
  field :current_sign_in_at,     type: Time
  field :last_sign_in_at,        type: Time
  field :current_sign_in_ip,     type: String
  field :last_sign_in_ip,        type: String

  def loves? list
    lovings.include?(list.id.to_s)
  end

  def love! list
    love list
    save and list.save
  end

  def ignore! list
    ignore list
    save and list.save
  end

  def following? user
    followings.include?(user.id.to_s)
  end

  def follow! user
    follow user
    save and user.save
  end

  def unfollow! user
    unfollow user
    save and user.save
  end

  def total_loves
    lists.sum(:loves)
  end

private

  def love list
    lovings.push(list.id.to_s) unless lovings.include? list.id.to_s
    list.lovers.push(id.to_s) unless list.lovers.include? id.to_s
    list.loves = list.lovers.count
  end

  def ignore list
    lovings.reject! {|id| id == list.id.to_s }
    list.lovers.reject! {|user_id| user_id == id.to_s }
    list.loves = list.lovers.count
  end

  def follow user
    followings.push(user.id.to_s) unless followings.include? user.id.to_s
    user.followers.push(id.to_s) unless user.followers.include? id.to_s
  end

  def unfollow user
    followings.reject! {|id| id == user.id.to_s}
    user.followers.reject! {|user_id| user_id == id.to_s }
  end
end
