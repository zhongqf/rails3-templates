gem 'devise', '>=1.1.2'
# If using HAML:
gem 'hpricot', '0.8.3', :group => :development
gem 'ruby_parser', '2.0.5', :group => :development

run "bundle install"

generate "devise:install"
generate "devise:views"
generate "devise User"

git :add => '.'
git :commit => '-m "Devise"'