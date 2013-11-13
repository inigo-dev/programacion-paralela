module Admin::PostsHelper

  def post_status(post)
    case
      when post.new?
        txt = "Nuevo"
        klass = 'info'
      when post.approved?
        txt = "Aprobado"
        klass = "success"
      when post.unapproved?
        txt = "Rechazado"
        klass = "important"
    end
    content_tag :span, txt, :class => "label label-#{klass}"
  end
end
