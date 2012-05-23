require 'action_view/helpers'

ActionView::Helpers::ActiveModelHelper.module_eval do
  def error_message_on(object, method, *args)
    options = args.extract_options!
    unless args.empty?
      ActiveSupport::Deprecation.warn('error_message_on takes an option hash instead of separate ' +
                                 'prepend_text, append_text, html_tag, and css_class arguments', caller)

      options[:prepend_text] = args[0] || ''
      options[:append_text] = args[1] || ''
      options[:html_tag] = args[2] || 'div'
      options[:css_class] = args[3] || 'formError'
    end
    options.reverse_merge!(:prepend_text => '', :append_text => '', :html_tag => 'div', :css_class => 'formError')

    object = convert_to_model(object)

    if (obj = (object.respond_to?(:errors) ? object : instance_variable_get("@#{object}"))) &&
        (errors = obj.errors[method]).presence
      content_tag(options[:html_tag],
              (options[:prepend_text].html_safe <<
                    I18n.t("activerecord.attributes." + object.class.to_s.underscore + "." + method.to_s, :default => method.to_s)  <<
                  errors.first).safe_concat(options[:append_text]),
              :class => options[:css_class]
              )
    else
      ''
    end
  end
end


ActionView::Helpers::FormBuilder.class_eval do
  def error_message_on(method, *args)
    @template.error_message_on(@object || @object_name, method, *args)
  end
end
