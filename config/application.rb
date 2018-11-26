require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module RailData
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
  end
end
# config.action_mailer.delivery_method = :smtp
#     ActionMailer::Base.smtp_settings = {
#     address: "smtp.gmail.com",
#     enable_starttls_auto: true,
#     port: 587,
#     authentication: :plain,
#     user_name: ENV["kalpeshadid"],
#     password: ENV["master@123"],
#     openssl_verify_mode: 'none'
#     }