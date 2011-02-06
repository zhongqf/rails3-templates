def heroku(cmd, arguments="")
  run "heroku #{cmd} #{arguments}"
end

app_name = ask "\r\n\r\nEnter the application name to use on heroku:"

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
gsub_file '.gitignore', /#^public\/stylesheets$/, ''

run "bundle exec compass compile --output-style compressed --force"

git :add => '.'
git :commit => "-a -m 'Add heroku .slugignore'"

heroku :create, app_name
heroku :"config:add", 'BUNDLE_WITHOUT="development:test"'
heroku :"addons:add", "custom_domains:basic"
heroku :"addons:add", "exceptional:basic"
heroku :"addons:add", "newrelic:bronze"
heroku :"addons:add", "cron:daily"

git :push => "heroku master"
heroku :rake, "db:migrate"
heroku :open