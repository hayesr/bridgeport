server "xray", :web, :app, :primary => true

namespace :deploy do
  task :start do ; end
  task :stop do ; end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  end

  desc "Link-up the db config"
  task :symlink_config do
    run "ln -nfs #{shared_path}/config/mongoid.yml #{release_path}/config/mongoid.yml"
  end
  
  desc "Link-up the image uploads dir"
  task :uploads_link do
    run "ln -nfs #{shared_path}/uploads #{release_path}/public/uploads"
  end
  
  desc "Set proper rights"
  task :ownership do
    run "chown -R apache: /var/www/rails/#{application}"
  end
  
end

after 'deploy:update_code' do
  run "cd #{release_path}; RAILS_ENV=production bundle exec rake assets:precompile"
end

after "deploy:update_code", "deploy:uploads_link"
after "deploy:update_code", "deploy:ownership"
