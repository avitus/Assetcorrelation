Assetcorrelation::Application.configure do
  # Settings specified here will take precedence over those in config/application.rb

  #===============================
  # Caching
  #===============================
  config.cache_classes = true                      # Code is not reloaded between requests
  config.consider_all_requests_local = false       # Full error reports are disabled
  config.cache_store = :dalli_store                # Use Memcached for cache
  config.action_controller.perform_caching = true

  #===============================
  # Asset Pipeline
  #===============================
  config.assets.compress = true               # Compress Javascript and CSS
  config.assets.js_compressor  = :uglifier    # Javascript compression
  config.assets.digest = true                 # Generate digests for assets URLs
  config.serve_static_assets = false          # Disable Rails's static asset server (Apache or nginx will already do this)

  # Don't fallback to assets pipeline if a precompiled asset is missed
  config.assets.compile = true # This should be false but seems to be a problem with Rails Admin ... try again with Rails 3.1.3

  # Precompile additional assets (application.js, application.css, and all non-JS/CSS are already added)
  # config.assets.precompile += %w( search.js )
  config.assets.precompile += %w(rails_admin/rails_admin.js rails_admin/rails_admin.css) # This is a temporary workaround until Rails 3.1.1 Should be able to remove

  # Ensure that Ckeditor assets are precompiled
  config.assets.precompile += Ckeditor.assets

  # Defaults to Rails.root.join("public/assets")
  # config.assets.manifest = YOUR_PATH

  #===============================
  # Content Delivery Network
  #===============================
  config.action_controller.asset_host = "http://d2fi0e71yegorg.cloudfront.net"  # Amazon Cloudfront
  config.static_cache_control = "public, max-age=86400"
  config.action_dispatch.x_sendfile_header = 'X-Accel-Redirect' # Header that Nginx uses for sending files

  #===============================
  # Logging
  #===============================
  config.logger = Logger.new(config.paths['log'].first, 5, 100.megabytes)  # Let Rails handle log rotation
  config.log_level = :info
  config.active_support.deprecation = :notify     # Send deprecation notices to registered listeners

  # Force all access to the app over SSL, use Strict-Transport-Security, and use secure cookies.
  # config.force_ssl = true

  # See everything in the log (default is :info)
  # config.log_level = :debug

  # Use a different logger for distributed setups
  # config.logger = SyslogLogger.new


  # Enable serving of images, stylesheets, and JavaScripts from an asset server
  # config.action_controller.asset_host = "http://assets.example.com"

  # Disable delivery errors, bad email addresses will be ignored
  # config.action_mailer.raise_delivery_errors = false

  # Enable threaded mode
  # config.threadsafe!

  # Enable locale fallbacks for I18n (makes lookups for any locale fall back to
  # the I18n.default_locale when a translation can not be found)
  config.i18n.fallbacks = true


  config.action_mailer.default_url_options = { :host => 'assetcorrelation.com' }
  # ActionMailer Config
  # Setup for production - deliveries, no errors raised
  config.action_mailer.delivery_method = :smtp
  config.action_mailer.perform_deliveries = true
  config.action_mailer.raise_delivery_errors = false
  config.action_mailer.default :charset => "utf-8"

end
