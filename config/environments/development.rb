Fonda::Application.configure do
  # Settings specified here will take precedence over those in config/application.rb.

  config.gem 'newrelic_rpm'

  # In the development environment your application's code is reloaded on
  # every request. This slows down response time but is perfect for development
  # since you don't have to restart the web server when you make code changes.
  config.cache_classes = false

  # Do not eager load code on boot.
  config.eager_load = false

  # Show full error reports and disable caching.
  config.consider_all_requests_local       = true
  config.action_controller.perform_caching = false

  # Don't care if the mailer can't send.
  config.action_mailer.raise_delivery_errors = false

  # Print deprecation notices to the Rails logger.
  config.active_support.deprecation = :log

  # Raise an error on page load if there are pending migrations
  config.active_record.migration_error = :page_load

  # Debug mode disables concatenation and preprocessing of assets.
  # This option may cause significant delays in view rendering with a large
  # number of complex assets.
  config.assets.debug = true

  #################################################################

  config.action_mailer.default_url_options = { :host => 'http://localhost:4200' }
  config.action_mailer.raise_delivery_errors = true
  config.action_mailer.perform_deliveries = true
  ActionMailer::Base.delivery_method = :smtp
  config.action_mailer.smtp_settings = {
     :authentication => :plain,
     :address => ENV['MAIL_ADDRESS'],
     :port => ENV['MAIL_PORT'],
     :user_name => ENV['MAIL_USERNAME'],
     :password => ENV['MAIL_PASSWORD']
  }
  config.after_initialize do
    Bullet.enable = true
    Bullet.alert = true
    Bullet.bullet_logger = true
    Bullet.console = true
    Bullet.rails_logger = true
    Bullet.add_footer = true
  end

  config.middleware.insert 0, Rack::Cors do

    allow do
      origins '*'
      resource '*', methods: [:get, :post, :put, :delete, :options], headers: :any
    end
  end
end

