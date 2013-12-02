module ApplicationHelper
  def cache_key_for_lists
    max_updated_at = List.max(:updated_at).try(:utc).try(:to_s, :number)
    "lists/all-#{max_updated_at}"
  end

  def minimal_form_for(object, *args, &block)
    options = args.extract_options!
    options[:html] = (options[:html] || {})
    options[:html][:class] = (options[:html][:class] || '') << " form-minimal"
    simple_form_for(object, *(args << options.merge(:builder => MinimalFormBuilder)), &block)
  end

  def horizontal_form_for(object, *args, &block)
    options = args.extract_options!
    options[:html] = (options[:html] || {})
    options[:html][:class] = (options[:html][:class] || '') << " form-horizontal"
    simple_form_for(object, *(args << options.merge(:builder => SimpleForm::FormBuilder)), &block)
  end

  def vertical_form_for(object, *args, &block)
    options = args.extract_options!
    options[:html] = (options[:html] || {})
    options[:html][:class] = (options[:html][:class] || '') << " form-vertical"
    simple_form_for(object, *(args << options.merge(:builder => SimpleForm::FormBuilder)), &block)
  end
end
