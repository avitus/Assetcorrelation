require 'rbconfig'
HOST_OS = Config::CONFIG['host_os']

source 'http://rubygems.org'

gem 'rails', '3.1.0'

group :development do
  gem 'sqlite3'
  gem "rails-footnotes", ">= 3.7"
  gem "airbrake"                                                          # Error notification  
end

group :production do
  gem 'mysql2', '>= 0.3'
  gem "airbrake"                                                          # Error notification
end

# Gems used only for assets and not required in production environments by default.
group :assets do
  gem 'sass-rails', "  ~> 3.1.0"
  gem 'coffee-rails', "~> 3.1.0"
  gem 'uglifier'
end

group :console do
  gem 'hirb'
end

group :test do 
  gem "factory_girl_rails", ">= 1.2.0"
  gem "cucumber-rails", ">= 1.0.2"
  gem "capybara", ">= 1.1.1"
  gem "database_cleaner", ">= 0.6.7"
  gem "launchy", ">= 2.0.5" 
end

# Deploy with Capistrano
gem 'capistrano'
gem 'capistrano-ext'

# To use debugger
# gem 'ruby-debug19', :require => 'ruby-debug'

# install a Javascript runtime for linux
if HOST_OS =~ /linux/i
  gem 'therubyracer', '>= 0.8.2'
end

gem 'jquery-rails'
gem "rspec-rails", ">= 2.6.1", :group => [:development, :test]
gem "devise", ">= 1.4.4"
gem "frontend-helpers"
gem 'rails_admin', :git => 'git://github.com/sferik/rails_admin.git'    # Admin panel
gem "breadcrumbs_on_rails", '>=2.0.0'                                   # For breadcrumb navigation bar
gem "yahoofinance"
gem "simple_form"                                                       # Easier forms with no opinion on styling
gem 'nested_form', :git => 'git://github.com/ryanb/nested_form.git'     # For handling multiple models in a single form
gem 'newrelic_rpm'                                                      # Performance monitoring -- add as low in list of gems as possible

