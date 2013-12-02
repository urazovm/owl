class MinimalFormBuilder < SimpleForm::FormBuilder

  def input(attribute_name, options = {}, &block)
    options[:placeholder] = I18n.t("simple_form.placeholders.defaults.#{attribute_name.to_s}").capitalize if options[:placeholder].blank?
    options[:label] = false
    options[:inline_label] = true if options[:inline_label].blank?
    options[:input_html] = (options[:input_html] || {}).merge({:class => 'input-block-level'})
    super
  end

end
