Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2, ENV['client_id'], ENV['client_secret'], scope: 'userinfo.profile,youtube'
end
