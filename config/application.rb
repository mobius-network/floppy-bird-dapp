require_relative 'boot'

require 'rails/all'

Bundler.require(*Rails.groups)

module FlappyBirdDapp
  class Application < Rails::Application
    config.load_defaults 5.1

    config.middleware.insert 0, Rack::Cors do
      allow do
        origins "*"
        resource '*', :headers => :any, :methods => [:get, :post, :options]
      end
    end
  end
end
