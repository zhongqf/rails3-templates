def heroku(cmd, arguments="")
  run "heroku #{cmd} #{arguments}"
end

envs = ask "\r\n\r\nEnter the list of environments to deploy NOW on heroku separated by commas, e.g.: staging, production (Leave empty for none):"
app_name = ask "\r\n\r\nEnter the application name to use on heroku:" unless envs.empty?

gem "heroku"
run "bundle install"

file ".slugignore", <<-EOS.gsub(/^  /, '')
  *.psd
  *.pdf
  test
  spec
  features
  doc
  docs
EOS

# The system in heroku is read-only (except for log and tmp)
# Instead of letting the server compile the stylesheets when the requests hits the server
# we commit the compiled stylesheets to the git repo
# and tell compass to never compile
append_file 'config/environments/production.rb', 'Sass::Plugin.options[:never_update] = true'
run "cp config/environments/production.rb config/environments/staging.rb"
gsub_file '.gitignore', /^public\/stylesheets$/, ''

run "bundle exec compass compile --output-style compressed --force"

git :add => '.'
git :commit => "-a -m 'Configuration for heroku'"

envs.split(", ").each do |env|
  next unless ["staging", "production"].include?(env)
  heroku :create, "#{app_name}-#{env} --remote heroku-#{env}"

  heroku :"config:add", "BUNDLE_WITHOUT='development:test' --app #{app_name}-#{env}"
  heroku :"config:add", "RACK_ENV=#{env} --app #{app_name}-#{env}"

  # addons
  heroku :"addons:add", "custom_domains:basic"
  heroku :"addons:add", "newrelic:bronze"
  heroku :"addons:add", "cron:daily"

  git :push => "heroku-#{env} master"
  heroku :rake, "db:migrate --app #{app_name}-#{env}"
  heroku :open, "--app #{app_name}-#{env}"
end