require_relative 'boot'

require 'rails/all'

# silence deprecation warnings
ActiveSupport::Deprecation.silenced = true

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module App
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
    
    # Force SSL
    config.force_ssl = true
  
    # Use Delayed Job
    config.active_job.queue_adapter = :delayed_job

    # Change the default security headers
    config.action_dispatch.default_headers = {
      'Referrer-Policy' => 'strict-origin-when-cross-origin',
      'X-Content-Type-Options' => 'nosniff',
      'X-Frame-Options' => 'SAMEORIGIN',
      'X-XSS-Protection' => '1; mode=block'
    }
  end
end
