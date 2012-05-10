source 'https://rubygems.org'

gem 'rails', '3.2.3'
gem 'thin'

# Bundle edge Rails instead:
# gem 'rails', :git => 'git://github.com/rails/rails.git'

# gem 'sqlite3'


# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'therubyracer'
  gem 'less-rails'
  gem 'coffee-rails', '~> 3.2.1'

  # See https://github.com/sstephenson/execjs#readme for more supported runtimes
  # gem 'therubyracer'

  gem 'uglifier', '>= 1.0.3'
end

gem 'jquery-rails'

gem 'mercury-rails', :git => 'https://github.com/jejacks0n/mercury.git'
gem 'carrierwave'
gem 'carrierwave-mongoid', :require => 'carrierwave/mongoid'
gem 'rmagick'

# Database Stuff
gem "mongoid", "~> 2.4"
gem "bson_ext", "~> 1.4"
gem "mongoid-tree"
gem "mongoid_session_store"

# Pagination
gem 'kaminari'

gem 'pry-rails', :group => :development

group :test, :development do
  gem "guard"
  gem 'guard-livereload'
  gem "thin"
  gem "rspec-rails", "~> 2.6"
  # gem "foreman"
  # gem "growl_notify"
  # gem "rb-fsevent"
  # gem 'guard-livereload'
  gem "guard-rails"
end

group :test do
  gem 'turn', :require => false
  #gem 'guard', :git => 'git://github.com/guard/guard.git', :branch => 'dev'
  gem 'spork', "> 0.9.0.rc"
  gem 'guard-spork'
  gem 'factory_girl_rails'
  gem 'capybara'
  gem 'guard-rspec'
end

# To use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'

# To use Jbuilder templates for JSON
# gem 'jbuilder'

# Use unicorn as the app server
# gem 'unicorn'

# Deploy with Capistrano
# gem 'capistrano'

# To use debugger
# gem 'ruby-debug19', :require => 'ruby-debug'
