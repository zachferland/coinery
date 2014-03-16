require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(:default, Rails.env)

module Coinery
  class Application < Rails::Application


    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    # config.time_zone = 'Central Time (US & Canada)'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    # config.i18n.default_locale = :de

    # turn off rails asset pipeline, override public dir
     config.assets.enabled = false
     config.paths['public'] = ['backbone/public']

     # serve compiled backone app assets
     config.serve_static_assets = true

     config.session_store :cookie_store
     config.api_only = false


     config.paperclip_defaults = {
        :storage => :s3,
        :s3_credentials => {
            :bucket => ENV['S3_BUCKET_NAME'],
            :access_key_id => ENV['AWS_ACCESS_KEY_ID'],
            :secret_access_key => ENV['AWS_SECRET_ACCESS_KEY']
        }
    }

    ActionMailer::Base.smtp_settings = {
        :user_name => ENV['SENDGRID_USER_NAME'],
        :password => ENV['SENDGRID_PASSWORD'],
        :domain => ENV['SENDGRID_DOMAIN'],
        :address => 'smtp.sendgrid.net',
        :port => 587,
        :authentication => :plain,
        :enable_starttls_auto => true
    }



  end
end
