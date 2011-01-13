Usage
=====

* There is a bug in Rails that prevents from using https URLs in the template paths. This is scheduled to be fixed in Rails 3.0.4. More info [here](https://rails.lighthouseapp.com/projects/8994/tickets/5926-bug-patch-allow-https-uris-to-be-supplied-for-rails-templates). This would be possible then:
`rails new app_name -J -m https://github.com/aentos/rails3-templates/main.rb`

* In the meantime you will have to clone this repo and then provide a relative path on your filesystem, e.g.:
`rails new app_name -J -m rails3-templates/main.rb`

Gems
====

General use
-----------
* [will_paginate](https://github.com/mislav/will_paginate)
* [attrtastic](https://github.com/MBO/attrtastic)
* [formtastic](https://github.com/justinfrench/formtastic)
* [haml-rails](https://github.com/indirect/haml-rails)
* [compass](https://github.com/chriseppstein/compass)
* [inherited_resources]

Development
-----------

Testing
-------
* [shoulda]
* [factory_girl]
* [cucumber]
* [capybara]
* [faker](http://faker.rubyforge.org/)

Optional
--------
* [hoptoad_notifier](https://github.com/thoughtbot/hoptoad_notifier)

Plugins
=======
* [asset_packager](https://github.com/sbecker/asset_packager)

Other tools
===========
* [960 grid system](http://960.gs/)
* [Hoptoad](http://hoptoadapp.com/)