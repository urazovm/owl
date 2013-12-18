module ApplicationHelper
  def cache_key_for_lists
    max_updated_at = List.unscoped.max(:updated_at).try(:utc).try(:to_s, :number)
    "lists/all-#{max_updated_at}"
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
