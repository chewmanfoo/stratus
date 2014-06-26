# NOTE: look for the gems in the sources listed below
# NOTE: in the order listed
source 'https://rubygems.org'
source :gemcutter
source :rubygems
source :rubyforge
source 'http://gems.github.com'

# NOTE: depends on rails at version 3.2.13
gem 'rails', '3.2.13'

# Bundle edge Rails instead:
# gem 'rails', :git => 'git://github.com/rails/rails.git'

gem 'mysql2'

# Gems used only for assets and not required
# in production environments by default.
group :assets do
# NOTE: depends on sass-rails >= 3.2.3 but < 3.3.0
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'

  # See https://github.com/sstephenson/execjs#readme for more supported runtimes
  # gem 'therubyracer', :platforms => :ruby

  gem 'uglifier', '>= 1.0.3'
  gem 'chosen-rails'


end

gem 'less'
gem "less-rails" #Sprockets (what Rails 3.1 uses for its asset pipeline) supports LESS
gem 'twitter-bootstrap-rails'
gem 'bootstrap-datepicker-rails'
gem 'select2-rails'
#gem 'client_side_validations', '3.2.0.beta.3', :git => 'https://github.com/bcardarella/client_side_validations.git'
gem 'client_side_validations'
gem 'simple_form', '2.0'

gem 'jquery-rails'

gem 'execjs'

gem 'therubyracer'

gem 'activeadmin'

gem 'term-ansicolor'

gem 'RedCloth'

gem 'sidekiq'

gem 'cancan'
gem "devise_ldap_authenticatable"

gem 'workflow'

#for sidekiq web
gem 'sinatra', require: false
gem 'slim'

#gem "nifty-generators", :group => :development

# To use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'

# To use Jbuilder templates for JSON
# gem 'jbuilder'

# Use unicorn as the app server
# gem 'unicorn'

# Deploy with Capistrano
# gem 'capistrano'

# To use debugger
# gem 'debugger'

# gem "mocha", :group => :test
gem "rails_best_practices"
gem 'will_paginate-bootstrap'
gem 'nokogiri'
gem 'xpath'

# modify logging
gem 'lograge'

gem 'rspec-rails', :group => [:test, :development]
group :test do
  gem 'factory_girl_rails'
  gem 'capybara'
  gem 'guard-rspec'
  gem 'rb-inotify', '~> 0.9'
end

group :development do
  gem 'meta_request', '0.2.1'
end

# NOTE: `bundle` == `bundle install`
# NOTE: gems may have dependencies encoded within them - so `bundle install` may install more gems than what is listed here
#
# NOTE: Gemfile.lock - created after bundle runs.  A snapshot of all the gems and versions installed
#
# NOTE: `bundle pack` - copies all the required gems (but not git gems) listed in Gemfile (and dependencies not listed) to vendor/cache.
#                       Bundler can run without connecting to the internet (or the Rubygems server) if all the gems you need are present 
#                       in that folder and checked in to your source control.
#
# NOTE: passenger has 
#       LoadModule passenger_module /usr/local/rvm/gems/ruby-1.9.3-p327/gems/passenger-3.0.18/ext/apache2/mod_passenger.so
#       PassengerRoot /usr/local/rvm/gems/ruby-1.9.3-p327/gems/passenger-3.0.18
#       PassengerRuby /usr/local/rvm/wrappers/ruby-1.9.3-p327/ruby
