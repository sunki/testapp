# config valid only for current version of Capistrano
lock '3.4.0'

set :application, 'testapp'
set :repo_url, 'git@github.com:sunki/testapp.git'

# Default branch is :master
# ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp

# Default deploy_to directory is /var/www/my_app_name
set :deploy_to, '/home/pub/testapp'

# Default value for :scm is :git
# set :scm, :git

# Default value for :format is :pretty
# set :format, :pretty

# Default value for :log_level is :debug
# set :log_level, :debug

# Default value for :pty is false
# set :pty, true

set :ssh_options, { forward_agent: true, auth_methods: %w(publickey password) }

# Default value for :linked_files is []
set :linked_files, fetch(:linked_files, []).push('config/database.yml', 'config/unicorn.rb', 'config/secrets.yml', '.ruby-gemset', '.ruby-version')

# Default value for linked_dirs is []
set :linked_dirs, fetch(:linked_dirs, []).push('log')

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

set :rvm_ruby_version, '2.1.1'

# Default value for keep_releases is 5
# set :keep_releases, 5

after 'deploy:publishing', 'deploy:restart'

namespace :deploy do
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      sudo :service, 'testapp restart'
    end
  end
end
