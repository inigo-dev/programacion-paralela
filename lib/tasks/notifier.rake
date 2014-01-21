namespace :notifier do
  desc 'Sends an email with the latest posts added (if any) to admins'
  task :send_updates => :environment do
    count = Post.new_posts.count(:id)
    Notifier.update_email(count).deliver if count > 0
  end
end
