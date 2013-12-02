class ItemDecorator < ApplicationDecorator
  def image(style)
    h.image_tag object.image.url(style), class: :image if object.image.exists?
  end

  def name
    h.content_tag :span, object.name, class: 'name'
  end
end
