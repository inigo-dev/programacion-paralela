module ApplicationHelper

  ALERT_TYPES = [:error, :info, :success, :warning]
  
  def password_placeholder(record)
    record.new_record? ? 'Password' : '(sin modificar)'
  end
  
  def provider_auth_url(provider)    
    "/auth/#{provider}"
  end
  
  def bootstrap_form_for(object, *args, &block)
    options = args.extract_options!
    form_for(object, *(args << options.merge(builder: BootstrapBuilder)), &block)
  end
  
  def bootstrap_fields_for(object, *args, &block)
    options = args.extract_options!
    args << nil if args.empty?
    fields_for(object, *(args << options.update(builder: BootstrapBuilder)), &block)
  end
  
  def pagination(collection, options={})
    will_paginate collection, options.merge(renderer: BootstrapPagination::Rails)
  end
  
  def bootstrap_flash
    flash_messages = []
    flash.each do |type, message|
      # Skip empty messages, e.g. for devise messages set to nothing in a locale file.
      next if message.blank?
      
      type = :success if type == :notice
      type = :error   if type == :alert
      next unless ALERT_TYPES.include?(type)

      Array(message).each do |msg|
        text = content_tag(:div,
                           content_tag(:button, raw("&times;"), :class => "close", "data-dismiss" => "alert") +
                           msg.html_safe, :class => "alert fade in alert-#{type}")
        flash_messages << text if msg
      end
    end
    flash_messages.join("\n").html_safe
  end
  

end
