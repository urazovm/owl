class User
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Slug

  has_many :lists
  validates_presence_of :login
  validates_uniqueness_of :login

  slug :login, history: false

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  field :email,                  type: String, default: ''
  field :login,                  type: String
  field :lovings,                type: Array,  default: []
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

private

  def love list
    lovings.push(list.id.to_s) unless lovings.include? list.id.to_s
    list.lovers.push(id.to_s) unless list.lovers.include? id.to_s
  end

  def ignore list
    lovings.reject! {|id| id == list.id.to_s }
    list.lovers.reject! {|user_id| user_id == id.to_s }
  end
end
