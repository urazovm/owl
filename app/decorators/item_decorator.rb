class ItemDecorator < ApplicationDecorator
  def image(style)
    h.image_lazy_tag object.image.url(style), class: :image if object.image.exists?
  end

  def name
    h.content_tag :h4, object.name, class: 'name'
  end

  def text
    h.content_tag :div, object.text, class: 'text'
  end
end
