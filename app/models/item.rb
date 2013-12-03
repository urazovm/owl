class Item
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Paperclip

  embedded_in :list
  validates_length_of :name, maximum: 900, allow_blank: true

  has_mongoid_attached_file :image,
    url: '/system/:class/:id/:basename-:style.:extension',
    default_url: '/assets/images/:style.jpg',
    styles: {
      small: ['120x120#',   :jpg],
      large: ['500x500#', :jpg] }
  validates_attachment_size :image, less_than: 800.kilobytes
  validates_attachment_content_type :image, content_type: ['image/jpeg', 'image/png', 'image/gif']

  field :name,     type: String
  field :position, type: Integer, default: 99999
end
