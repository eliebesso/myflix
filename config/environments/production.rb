Myflix::Application.configure do

  config.cache_classes = true
  config.eager_load = true
  config.consider_all_requests_local       = false
  config.action_controller.perform_caching = true

  config.serve_static_assets = false

  config.assets.compress = true
  config.assets.js_compressor = :uglifier

  config.assets.compile = false

  config.assets.digest = true

  config.i18n.fallbacks = true

  config.active_support.deprecation = :notify

  config.action_mailer.delivery_method = :smtp
  config.action_mailer.perform_deliveries = true

  config.action_mailer.smtp_settings = {
  # ActionMailer::Base.smtp_settings = {
    :user_name =>            ENV["SENDGRID_USERNAME"],
    :password =>             ENV["SENDGRID_PASSWORD"],
    :address =>              'smtp.sendgrid.net',
    :port =>                 587,
    :authentication =>       :plain,
    :enable_starttls_auto => true
  }

  config.action_mailer.default_url_options = { protocol: 'https', :host => ENV["SENDGRID_HOST"] }

end




