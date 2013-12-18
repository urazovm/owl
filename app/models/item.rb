class Item
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Paperclip

  TYPES = [ :text, :image, :link ]

  embedded_in :list
  validate :must_not_be_empty, on: :update
  validates_presence_of :type
  validates_length_of :name, maximum: 250, allow_blank: true
  validates_length_of :text, maximum: 1000, allow_blank: true
  validates_length_of :link, maximum: 2000, allow_blank: true
  after_validation :update_status

  has_mongoid_attached_file :image,
    url: '/system/:class/:id/:basename-:style.:extension',
    default_url: '/assets/images/:style.jpg',
    styles: {
      small: ['120x120#',   :jpg],
      large: ['400x400#', :jpg] }
  validates_attachment_size :image, less_than: 800.kilobytes
  validates_attachment_content_type :image, content_type: ['image/jpeg', 'image/png', 'image/gif']

  field :name,      type: String
  field :text,      type: String
  field :link,      type: String
  field :type,      type: Integer
  field :position,  type: Integer, default: 99999
  field :completed, type: Boolean, default: false

  def type_name
    TYPES.at(type)
  end

  def index
    list.items.index(self)
  end

  def text?
    type == TYPES.index(:text)
  end

  def image?
    type == TYPES.index(:image)
  end

  def link?
    type == TYPES.index(:link)
  end

  def link_valid?
    uri = URI.parse(link)
    uri.kind_of?(URI::HTTP||URI::HTTPS)
  rescue URI::InvalidURIError
    false
  end

private

  def must_not_be_empty
    case type
    when TYPES.index(:text)
      errors.add(:name, :name_or_text_missing) if name.blank? || text.blank?
    when TYPES.index(:image)
      errors.add(:image, :missing) unless image.exists?
    when TYPES.index(:link)
      errors.add(:link, :missing) if link.blank?
      errors.add(:link, :invalid) if !link.blank? && !link_valid?
    end
  end

  def update_status
    case type
    when TYPES.index(:text) then self.completed = !name.blank? || !text.blank?
    when TYPES.index(:image) then self.completed = image.exists?
    when TYPES.index(:link) then self.completed = !link.blank?
    else
      self.completed = false
    end
  end
end
