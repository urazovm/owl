class ItemDecorator < ApplicationDecorator
  delegate :type

  def image(style)
    if object.image.exists?
      if h.request.parameters['action'] == 'edit'
        h.image_lazy_tag object.image.url(style), class: "image #{style}"
      else
        h.image_tag object.image.url(style), class: "image #{style}"
      end
    end
  end

  def name
    h.content_tag :h4, object.name, class: 'name'
  end

  def text
    h.content_tag :div, object.text, class: 'text'
  end

  def link
    h.link_to h.truncate(object.link, length: 50, omission: '…'), object.link, class: 'link', target: '_blank'
  end
end
