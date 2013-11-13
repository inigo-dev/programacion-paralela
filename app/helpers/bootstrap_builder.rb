class BootstrapBuilder < ActionView::Helpers::FormBuilder
  
  def self.create_inline_errors_field(method_name)
    define_method(method_name) do |method, *args|
      options = args.extract_options!
      
      t = @template        
      if @object.errors[method].present?
        options[:class] ||= ""
        spans = options[:class].scan(/span\d+/)
        options[:class] = options[:class].gsub(/span\d+/, "")
        klass = spans.join(" ") << ' error'
        t.content_tag(:div, :class => klass) do
          options[:class] << " input-block-level" if spans.any?
          (super method, options) +
          t.content_tag(:span, @object.errors.messages[method].join(",").html_safe, :class => 'help-block')
        end
      else
        super method, options        
      end
    end
  end
  
  [ 
    :text_field, :password_field, :hidden_field, 
    :file_field, :text_area, :check_box,
    :radio_button, :color_field, :search_field,
    :telephone_field, :phone_field, :url_field, 
    :email_field,:number_field, :range_field
  ].each do |method|
    create_inline_errors_field(method)
  end
  
end
