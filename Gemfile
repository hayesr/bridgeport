source 'https://rubygems.org'

gem 'rails', '3.2.3'
gem 'thin'

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  # See https://github.com/sstephenson/execjs#readme for more supported js runtimes
  gem 'therubyracer'
  gem 'less-rails'
  gem 'coffee-rails', '~> 3.2.1'
  gem 'uglifier', '>= 1.0.3'
end

gem 'jquery-rails'

# Editor & File uploads
gem 'mercury-rails', :git => 'https://github.com/jejacks0n/mercury.git'
gem 'carrierwave'
gem 'carrierwave-mongoid', :require => 'carrierwave/mongoid'
gem 'rmagick'
gem 'liquid'

# Database Stuff
gem "mongoid", "~> 3.0.2"
# gem "bson_ext", "~> 1.4"
gem "mongoid-ancestry", :git => 'https://github.com/hayesr/mongoid-ancestry.git'
gem "mongoid_session_store", :git => 'https://github.com/fabricelejeune/mongoid_session_store.git'

# Pagination
gem 'kaminari'

# Users & Permissions
gem 'devise'
gem 'cancan'

group :development do
  # Dev Console
  gem 'pry-rails'
  gem 'pry-remote'
end

gem 'capistrano'
gem 'capistrano-ext'

group :test, :development do
  gem "guard"
  gem 'guard-livereload'
  gem "thin"
  gem "rspec-rails", "~> 2.6"
  gem "guard-rails"
end

group :test do
  gem 'turn', :require => false
  gem 'spork', "> 0.9.0.rc"
  gem 'guard-spork'
  gem 'factory_girl_rails'
  gem 'capybara'
  gem 'guard-rspec'
end
