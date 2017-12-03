require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module FatecIhcProntuario
  class Application < Rails::Application
    config.load_defaults 5.1
    config.i18n.load_path += Dir[
      Rails.root.join('config', 'locales', '**', '*.{rb,yml}').to_s
    ]
    config.time_zone = 'Brasilia'
    config.i18n.available_locales = ['pt-BR']
    config.i18n.default_locale = :'pt-BR'
    I18n.enforce_available_locales = true
  end
end
