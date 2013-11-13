class ItemDecorator < ApplicationDecorator
  def title
    position + ' - ' + name
  end

  def name
    h.content_tag :span, object.name, class: 'name'
  end

  def position
    h.content_tag :strong, (object.position + 1), class: 'position'
  end
end
