# encoding: utf-8
require 'rbconfig'
HOST_OS = RbConfig::CONFIG['host_os']
source 'http://rubygems.org'

gem 'rails', '3.2.11'

group :development do
  gem 'sqlite3'
  gem 'rails-footnotes', '>= 3.7'
  gem 'better_errors'
  gem 'binding_of_caller'
end

group :production do
  gem 'mysql2', '>= 0.3'
  gem 'memcache-client'
end

# Gems used only for assets and not required in production environments by default.
group :assets do
  gem 'sass-rails',   ' ~> 3.2.3 '
  gem 'coffee-rails', ' ~> 3.2.1 '
  gem 'uglifier',     ' >= 1.0.3 '
end

group :console do
  gem 'hirb'
end

group :test do
  gem 'factory_girl_rails', '>= 1.2.0'
  gem 'cucumber-rails', '>= 1.0.2'
  gem 'capybara', '>= 1.1.1'
  gem 'database_cleaner', '>= 0.6.7'
  gem 'launchy', '>= 2.0.5'
end

# Deploy with Capistrano
gem 'capistrano'
gem 'capistrano-ext'

# To use debugger
# gem 'ruby-debug19', :require => 'ruby-debug'

# install a Javascript runtime for linux
if HOST_OS =~ /linux/i
  gem 'libv8', '>= 3.11.8.3'
  gem 'therubyracer', '>= 0.11.0'
end

gem 'jquery-rails'
gem 'rspec-rails', '>= 2.6.1', :group => [:development, :test]
gem 'devise'
gem 'frontend-helpers'
gem 'rails_autolink'                                                    # Restore auto_link functionality from Rails 3.0
gem 'rails_admin', :git => 'git://github.com/sferik/rails_admin.git'    # Admin panel
gem 'breadcrumbs_on_rails', '>=2.0.0'                                   # For breadcrumb navigation bar
gem 'yahoofinance'                                                      # For stock quote retrieval
gem 'json'                                                              # Only required for parsing JSON response from Datasift API
gem 'topsy'                                                             # Ruby wrapper for Topsy API

gem 'simple_form'                                                       # Easier forms with no opinion on styling
gem 'nested_form', '=0.2.3'                                             # For handling multiple models in a single form (newer versions of gem break code)

gem 'airbrake'                                                          # Error notification
gem 'stripe'                                                            # Payment gateway
gem 'newrelic_rpm'                                                      # Performance monitoring -- add as low in list of gems as possible


