require_relative "boot"

require "rails/all"
#require 'jp_prefecture'
# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module IeLog
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.1
    config.paths.add 'lib', eager_load: true # 追加
    config.time_zone = 'Tokyo'
    config.i18n.default_locale = :ja
  end
end
