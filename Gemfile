source 'https://rubygems.org'
gem 'rails', '3.2.8'
gem 'sqlite3'
group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'
  gem 'uglifier', '>= 1.0.3'
end
gem 'jquery-rails'
gem "haml", ">= 3.1.7"
gem "haml-rails", ">= 0.3.5", :group => :development
gem "hpricot", ">= 0.8.6", :group => :development
gem "ruby_parser", ">= 2.3.1", :group => :development
gem "rspec-rails", ">= 2.11.0", :group => [:development, :test]
gem "capybara", ">= 1.1.2", :group => :test
gem "email_spec", ">= 1.2.1", :group => :test
gem "factory_girl_rails", ">= 4.1.0", :group => [:development, :test]
gem "bootstrap-sass", ">= 2.1.0.0"
gem "simple_form", ">= 2.0.4"
gem "quiet_assets", ">= 1.0.1", :group => :development
gem 'omniauth-github'
gem 'omniauth-twitter'
gem 'cancan'
gem 'tabs_on_rails'

gem 'capistrano'
gem 'puret'
gem 'rubyzip'
gem 'bing_translator'
gem 'will_paginate', '~> 3.0'
gem 'exception_notification'

group :development do
  gem 'thin'
end

group :test do
  gem 'database_cleaner'
end

group :development, :test do
  gem "debugger"
end

group :production do
  gem 'mysql2' # If using mysql in development, this can be outside the production group.
  gem 'therubyracer'
end
