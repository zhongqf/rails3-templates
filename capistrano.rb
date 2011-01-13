app_name = ask "\r\n\r\nEnter the application name:"
server = ask "\r\n\r\nEnter the servername or IP:"
git_repo = ask "\r\n\r\nEnter the git repo URL, e.g. git@github.com:aentos/app.git :"
hoptoad = yes?"\r\n\r\nDo you want to include hoptoad notifier in your capistrano configuration? (yes/no)"

gem "capistrano"
gem "capistrano-ext", :require => "capistrano"


run "bundle install"
capify!

file 'config/deploy/staging.rb', <<-FILE
#############################################################
#       Settings
#############################################################
set :rails_env, "staging"

# Application Settings
set :application,   "#{app_name}"
set :user,          "deploy"
set :deploy_to,     "/var/rails/#{app_name}_staging"
set :use_sudo,      false
set :keep_releases, 5

# Server Roles
role :web, "#{server}"
role :app, "#{server}"
role :db,  "#{server}", :primary => true

FILE

file 'config/deploy/production.rb', <<-FILE
#############################################################
#       Settings
#############################################################
set :rails_env, "production"

# Application Settings
set :application,   "#{app_name}"
set :user,          "deploy"
set :deploy_to,     "/var/rails/#{app_name}_production"
set :use_sudo,      false
set :keep_releases, 5

# Server Roles
role :web, "#{server}"
role :app, "#{server}"
role :db,  "#{server}", :primary => true

FILE

file 'config/deploy.rb', <<-FILE
 
FILE
git :add => '.'
git :commit => '-m "Capistrano"'