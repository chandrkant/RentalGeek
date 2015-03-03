# config valid only for Capistrano 3.1
lock '3.2.1'

set :application, 'fonda'
set :repo_url, 'git@github.com:RentalGeek/fonda.git'

# Default branch is :master
# ask :branch, proc { `git rev-parse --abbrev-ref HEAD`.chomp }

# Default deploy_to directory is /var/www/my_app
set :deploy_to, '/var/www/fonda'

# Default value for :scm is :git
# set :scm, :git

# Default value for :format is :pretty
# set :format, :pretty

# Default value for :log_level is :debug
# set :log_level, :debug

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
set :linked_files, %w{
  config/database.yml
  config/initializers/secret_token.rb
  config/initializers/mandrill-api.rb }

# Default value for linked_dirs is []
# set :linked_dirs, %w{bin log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system}

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for keep_releases is 5
# set :keep_releases, 5

set :rvm_ruby_version, '2.1.2'

set :unicorn_pid, "/var/www/fonda/shared/pids/unicorn.pid"

namespace :deploy do

  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      # Your restart mechanism here, for example:
      # execute :touch, release_path.join('tmp/restart.txt')
    end
  end

  after :publishing, :restart

  after :restart, :clear_cache do
    on roles(:web), in: :groups, limit: 3, wait: 10 do
      # Here we can do anything such as:
      # within release_path do
      #   execute :rake, 'cache:clear'
      # end
    end
  end

end

# if preload_app:true use:
after 'deploy:publishing', 'deploy:restart'
namespace :deploy do
  task :restart do
    invoke 'unicorn:restart'
  end
end

after 'deploy:restart', 'airbrake:deploy'

namespace :db do

  desc "Copy production data to localhost"
  task :copy_to_localhost do
    timestamp = Time.now.to_i

    on roles(:db) do
      with rails_env: :production do
        execute "touch /tmp/fonda-production-dump-#{timestamp}.sql"
        execute "chmod 600 -v /tmp/fonda-production-dump-#{timestamp}.sql"
        
        db_config = nil # to fix block scope -JC
        within current_path do
  	    	db_config = YAML.load(capture :bundle, "exec rails runner", '\'puts Rails.configuration.database_configuration["production"].to_yaml\'')
  	    end

	      execute "pg_dump --no-password --blobs --clean -U #{db_config['username']} -h #{db_config['host']} -p #{db_config['port']} #{db_config['database']} > /tmp/fonda-production-dump-#{timestamp}.sql"

	      system("scp --progress fonda.rentalgeek.com:/tmp/fonda-production-dump-#{timestamp}.sql ./db/")
      end
    end
  end
end

