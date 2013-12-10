module Admin::TagsHelper

  def tag_type_label(tag)
    if tag.featured?
      content_tag :span, 'featured', :class => 'label label-info'
    end
  end
end
