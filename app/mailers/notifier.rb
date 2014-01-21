# encoding: UTF-8
class Notifier < ActionMailer::Base
  default from: "Programación Paralela <notificaciones@programacionparalela.com>"
  
  def update_email(new_posts_count)
    @count = new_posts_count
    emails = Admin.pluck(:email)
    mail(:to => emails, :subject => "Existe nuevo contenido listo para ser publicado")
  end
end
