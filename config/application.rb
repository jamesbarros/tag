require File.expand_path('../boot', __FILE__)

require "rails"
# Pick the frameworks you want:
require "active_model/railtie"
require "active_job/railtie"
require "active_record/railtie"
require "action_controller/railtie"
require "action_mailer/railtie"
require "action_view/railtie"
require "sprockets/railtie"
# require "rails/test_unit/railtie"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Demot2
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    config.time_zone = 'Pacific Time (US & Canada)'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    # config.i18n.default_locale = :de

    # Do not swallow errors in after_commit/after_rollback callbacks.
    config.active_record.raise_in_transactional_callbacks = true

    # config/application.rb : Set Queueing backend:
    config.active_job.queue_adapter = :delayed_job

    # Serve assets
    # https://devcenter.heroku.com/articles/rails-4-asset-pipeline
    # enable this if one feels the 12factorgem isn't doing this automagically
    # it merely enables serving everything in the `public` folder and is unrelated to the asset pipeline
    config.serve_static_files = true

    config.assets.compile = true
    # http://stackoverflow.com/questions/18324063/rails-4-images-not-loading-on-heroku
    #
    # http://stackoverflow.com/questions/19200913/heroku-does-not-serve-background-image-localhost-does
    # config.cache_classes = true
    # config.assets.digest = true

  end
end
