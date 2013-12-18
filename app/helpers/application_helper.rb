module ApplicationHelper
  def cache_key_for_lists
    max_updated_at = List.unscoped.max(:updated_at).try(:utc).try(:to_s, :number)
    "lists/all-#{max_updated_at}"
  end

  def has_tmp_list? list
    cookies.signed[:owl_lists] && cookies.signed[:owl_lists].include?(list.id.to_s)
  end

  def tmp_list_cookie_updated_at
    cookies.signed[:owl_updated_at] || 0
  end

  def minimal_form_for(object, *args, &block)
    options = args.extract_options!
    options[:html] = (options[:html] || {})
    options[:html][:class] = (options[:html][:class] || '') << " form-minimal"
    simple_form_for(object, *(args << options.merge(:builder => MinimalFormBuilder)), &block)
  end

  def image_lazy_tag(source, options = {})
      options['data-echo'] = source
      image_tag('/assets/blank.gif', options)
  end
end
