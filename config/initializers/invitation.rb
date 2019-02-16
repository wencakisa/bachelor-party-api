Invitation.configure do |config|
  config.user_registration_url = ->(params) { Rails.application.credentials.client[:register_url] }
  config.mailer_sender = Rails.application.credentials.gmail[:username]
end
