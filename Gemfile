# encoding: utf-8
source 'http://rubygems.org'
require 'rbconfig'

############################################################
# Frameworks
############################################################
ruby "2.4.3"
gem 'rails', '5.1'                                                           
gem 'jquery-rails'
gem 'jquery-ui-rails'

############################################################
# Databases
############################################################
group :production do
  gem 'mysql2', '>= 0.4'
  gem 'memcache-client'
  gem 'dalli'                                                           # Memcached client
end

############################################################
# Assets (Gems nore required in production environment)
############################################################
group :assets do
  gem 'sass-rails'
  gem 'compass-rails'                                                   # Now has Rails 4 support
  gem 'coffee-rails'
  gem 'uglifier'                                                        # JS compression
end

############################################################
# Application Gems
############################################################
gem 'devise'
# gem 'frontend-helpers'
gem 'rails_autolink'                                                    # Restore auto_link functionality from Rails 3.0
gem 'rails_admin'                                                       # Admin panel
gem 'breadcrumbs_on_rails', '>=2.0.0'                                   # For breadcrumb navigation bar
gem 'yahoofinance'                                                      # For stock quote retrieval
gem 'json'                                                              # Only required for parsing JSON response from Datasift API
gem 'topsy'                                                             # Ruby wrapper for Topsy API
gem 'simple_form'                                                       # Easier forms with no opinion on styling
gem 'airbrake'                                                          # Error notification
gem 'stripe'                                                            # Payment gateway
gem 'newrelic_rpm'                                                      # Performance monitoring -- add as low in list of gems as possible

############################################################
# Development
############################################################
group :development do
  gem 'sqlite3'
  gem 'rails-footnotes'
  gem 'better_errors'
end

############################################################
# Testing
############################################################
group :test do
  gem 'factory_girl_rails'
  gem 'rspec-rails'
  gem 'cucumber-rails', require: false 
  gem 'capybara'
  gem 'database_cleaner'
  gem 'launchy'
end

############################################################
# Deployment
############################################################
gem 'capistrano', "~> 3.8"                                              # Deploy with Capistrano
gem 'capistrano-rails'                                                  # Rails-specific tasks for Capistrano
gem 'capistrano-rvm' 

############################################################
# Console
############################################################
group :console do
  gem 'hirb'
end
