Rails.application.config.middleware.use OmniAuth::Builder do
  provider :developer unless Rails.env.production?
  provider :github, CONFIG[:github][:key], CONFIG[:github][:secret], scope: "user"
  provider :facebook, CONFIG[:facebook][:key], CONFIG[:facebook][:secret], image_size: 'normal', auth_type: 'reauthenticate'
  provider :twitter, CONFIG[:twitter][:key], CONFIG[:twitter][:secret]
end
