OpenSSL::SSL::VERIFY_PEER = OpenSSL::SSL::VERIFY_NONE

puts "\r\n\r\n*****************************************************************************************************"
puts "Let me ask you a few questions before i start bootstrapping your app"
puts "*****************************************************************************************************"

hoptoad_key = ask("\r\n\r\nWant to use your Hoptoad Account? (Skip if you are deploying to heroku)\n\r\n\rEnter your API Key, or press Enter to skip")
locale_str = ask("\r\n\r\nEnter a list of locales you want to use separated by commas (e.g. 'es, de, fr'). For a reference list visit https://github.com/svenfuchs/rails-i18n/tree/master/rails/locale/. Press enter to skip: ")
auth_option = ask("\r\n\r\nWhat authentication framework do you want to use?\r\n\r\n(1) Devise\r\n(2) Authlogic\r\n(3) Omniauth\r\nPress Enter to skip")
paginator_option = ask("\r\n\r\nWhich paginator do you want to use?\r\n\r\n(1) will_paginate\r\n(2) Kaminari\r\nPress Enter to skip")
deploy_option = ask("\r\n\r\nWhat deploy method/target do you want to use?\r\n\r\n(1) Capistrano\r\n(2) Heroku\r\nPress Enter to skip")
css_framework_option = ask("\r\n\r\nWhat CSS framework do you want to use?\r\n\r\n(1) 960\r\n(2) Blueprint\r\nPress Enter for 960 (default)")
form_builder_option = ask("\r\n\r\nWhat form/view builder do you want to use?\r\n\r\n(1) formtastic/attrtastic\r\n(2) simple_form/show_for\r\nPress Enter for formtastic/attrtastic (default)")
permalinks = yes?("\r\n\r\nDo you need permalinks in your app? If that's the case I will install friendly_id for you.")

if ["1", "2", "3"].include?(auth_option)
  auth = "devise" if auth_option=="1"
  auth = "authlogic" if auth_option=="2"
  auth = "omniauth" if auth_option=="3"
end

if ["1", "2"].include?(paginator_option)
  paginator = "will_paginate" if paginator_option=="1"
  paginator = "kaminari" if paginator_option=="2"
end

if ["1", "2"].include?(deploy_option)
  deploy = "capistrano" if deploy_option=="1"
  deploy = "heroku" if deploy_option=="2"
end

if ["1", "2"].include?(css_framework_option)
  css_framework = "960" if css_framework_option=="1"
  css_framework = "blueprint" if css_framework_option=="2"
else
  css_framework = "960"
end

if ["1", "2"].include?(form_builder_option)
  form_builder = "formtastic" if form_builder_option=="1"
  form_builder = "simple_form" if form_builder_option=="2"
else
  form_builder = "formtastic"
end

puts "\r\n\r\n*****************************************************************************************************"
puts "All set. Bootstrapping your app!!"
puts "*****************************************************************************************************\r\n\r\n"

# GO!
run "rm -Rf .gitignore README public/index.html public/images/rails.png public/javascripts/* app/views/layouts/*"

if paginator == "will_paginate"
  gem 'will_paginate', '>=3.0.pre2'
elsif paginator == "kaminari"
  gem 'kaminari'
end
gem "haml-rails", ">= 0.2"
gem "compass", ">= 0.10.5"
gem "fancy-buttons"
gem "compass-960-plugin" if css_framework=="960"
gem 'inherited_resources', '~> 1.1.2'
if form_builder == "simple_form"
  gem "simple_form"
  gem "show_for"
else
  gem "formtastic"
  gem "attrtastic"
end
gem "meta_search"

# other stuff
gem('friendly_id', '~>3.1') if permalinks

# development
gem "rails-erd", :group => :development
gem 'wirble', :group => :development
gem 'awesome_print', :group => :development
gem "hirb", :group => :development

# testing
gem "factory_girl_rails", :group => [:test, :test]
gem "shoulda", :group => [:test, :shoulda]
gem "faker", :group => [:test, :test]
gem "mynyml-redgreen", :group => :test, :require => "redgreen"

gem 'cucumber', "~> 0.10.0", :group => :test
gem 'cucumber-rails', "~> 0.3.2", :group => :test
gem 'capybara', "~> 0.4.1", :group => :test
gem 'database_cleaner', "~> 0.5.0", :group => :test
gem "pickle", "~> 0.4.2", :group => :test
gem "launchy", :group => :test

# staging & production stuff
unless hoptoad_key.empty?
  gem "hoptoad_notifier", '~> 2.3.6'
  initializer 'hoptoad.rb', <<-FILE
HoptoadNotifier.configure do |config|
  config.api_key = '#{hoptoad_key}'
end
FILE
end

gem 'rails3-generators', :group => :development

run "bundle install"

application  <<-GENERATORS
  config.generators do |g|
      g.orm :active_record
      g.stylesheets false
      g.template_engine :haml
      g.test_framework  :shoulda, :fixture_replacement => :factory_girl
      g.fallbacks[:shoulda] = :test_unit
      g.integration_tool :test
      g.helper false
#{"      g.form_builder :formtastic" if form_builder == "formtastic"}
    end
GENERATORS

# configure cucumber
generate "cucumber:install --capybara --testunit"
generate "pickle --path --email"
get "https://github.com/zhongqf/rails3-templates/raw/master/within_steps.rb" ,"features/step_definitions/within_steps.rb"

generate "friendly_id" if permalinks

if form_builder == "simple_form"
  generate "simple_form:install -e haml"
  generate "show_for:install"
  file "lib/templates/haml/scaffold/show.html.haml", <<-FILE
  = show_for @<%= singular_name %> do |s|
  <% attributes.each do |attribute| -%>
    = s.<%= attribute.reference? ? :association : :attribute %> :<%= attribute.name %>
  <% end -%>

  == \#{link_to 'Edit', edit_<%= singular_name %>_path(@<%= singular_name %>) } | \#{ link_to 'Back', <%= plural_name %>_path }
  FILE
else
  generate 'formtastic:install'
  run "rm -Rf public/stylesheets/formtastic.css public/stylesheets/formtastic_changes.css"
  file "lib/templates/haml/scaffold/show.html.haml", <<-FILE
= semantic_attributes_for @<%= singular_name %> do |s|
  = s.attributes do
<% attributes.each do |attribute| -%>
    = s.<%= attribute.reference? ? :association : :attribute %> :<%= attribute.name %>
<% end -%>

== \#{link_to 'Edit', edit_<%= singular_name %>_path(@<%= singular_name %>) } | \#{ link_to 'Back', <%= plural_name %>_path }
FILE
end

# compass
run "gem install compass"
if css_framework=="960"
  run "bundle exec compass init -r ninesixty --using 960 --app rails --css-dir public/stylesheets"
  get "https://github.com/zhongqf/rails3-templates/raw/master/application_960.html.haml", "app/views/layouts/application.html.haml"
else
  run "bundle exec compass init --using blueprint --app rails --css-dir public/stylesheets"
  get "https://github.com/zhongqf/rails3-templates/raw/master/application_blueprint.html.haml", "app/views/layouts/application.html.haml"
end
create_file "app/stylesheets/partials/_colors.scss"
get "https://github.com/zhongqf/rails3-templates/raw/master/handheld.scss" ,"app/stylesheets/handheld.scss"

unless locale_str.empty?
  locales = locale_str.split(",")
  locales.each do |loc|
    get("https://github.com/svenfuchs/rails-i18n/raw/master/rails/locale/#{loc.strip}.yml", "config/locales/#{loc.strip}.yml")
  end
end

# jquery
get "https://github.com/rails/jquery-ujs/raw/master/src/rails.js", "public/javascripts/rails.js"

get "https://github.com/zhongqf/rails3-templates/raw/master/gitignore" ,".gitignore"
get "https://github.com/zhongqf/rails3-templates/raw/master/build.rake", "lib/tasks/build.rake"

# keep development and test log files small: http://trevorturk.com/2010/10/14/limit-the-size-of-rails-3-log-files/
['development','test'].each do |env|
  inject_into_file "config/environments/#{env}.rb", :before => "end" do
    <<-RUBY
      config.logger = Logger.new(config.paths.log.first, 1, 5.megabytes)
    RUBY
  end  
end

git :init
git :add => '.'
git :commit => '-am "Initial commit"'

apply "https://github.com/zhongqf/rails3-templates/raw/master/#{auth}.rb" unless auth.blank?
apply "https://github.com/zhongqf/rails3-templates/raw/master/#{deploy}.rb" unless deploy.blank?

puts "SUCCESS!"