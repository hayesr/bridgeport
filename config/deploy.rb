require "bundler/capistrano"

set :stages, %w(production staging)
set :default_stage, "staging"
require 'capistrano/ext/multistage'

set :application, "bridgeport"
set :repository,  "set your repository location here"

set :scm, :git

set :user, "root"
set :group, "apache"
set :domain, 'do7.saugus.k12.ca.us'

set :repository, "#{user}@#{domain}:repos/#{application}"
set :deploy_to, "/var/www/rails/#{application}"
set :deploy_via, :remote_cache
set :deploy_env, 'production'

default_run_options[:pty] = true

