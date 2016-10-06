require_relative 'boot'

require "rails"
# Pick the frameworks you want:
require "active_model/railtie"
require "active_job/railtie"
require "active_record/railtie"
require "action_controller/railtie"
require "action_mailer/railtie"
require "action_view/railtie"
require "action_cable/engine"
# require "sprockets/railtie"
require "rails/test_unit/railtie"
require './app/middleware/throttle_request'

Bundler.require(*Rails.groups)

module RailsLimit
  class Application < Rails::Application
    config.api_only = true

    config.middleware.use ThrottleRequest

    config.generators do |g|
      g.test_framework  :rspec
      g.stylesheets     false
      g.javascripts     false
      g.factory_girl    dir: 'spec/factories'
    end
  end
end
