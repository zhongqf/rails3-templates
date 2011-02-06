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
git :add => '.'
git :commit => "-a -m 'Add heroku .slugignore'"

heroku :create, app_name
heroku :"addons:add", "custom_domains:basic"
heroku :"addons:add", "exceptional:basic"
heroku :"addons:add", "newrelic:bronze"
heroku :"addons:add", "cron:daily"

git :push => "heroku master"
heroku :rake, "db:migrate"
heroku :open