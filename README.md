Usage
=====

* If you are using Rails >= 3.0.4:
`rails new app_name -J -m https://github.com/aentos/rails3-templates/main.rb`

* If you are using an older version of Rails 3, there is a bug in Rails that prevents from using https URLs in the template paths. This was fixed in Rails 3.0.4. More info [here](https://rails.lighthouseapp.com/projects/8994/tickets/5926-bug-patch-allow-https-uris-to-be-supplied-for-rails-templates). You will have to clone this repo and then provide a relative path on your filesystem, e.g.:
`rails new app_name -J -m rails3-templates/main.rb`

About
=====

This template comes with a suite of opinionated components that we find end up using in almost all of our projects. Other components that might depend on the project are presented as a set of questions for you to choose from or skip.

Stuff it will put in your app without asking
--------------------------------------------

### Development
* [rails-erd](http://rails-erd.rubyforge.org/)
* [wirble](https://github.com/blackwinter/wirble)
* [awesome_print](https://github.com/michaeldv/awesome_print)
* [hirb](https://github.com/cldwalker/hirb)

### Testing (unit and acceptance tests)
* [shoulda](http://github.com/thoughtbot/shoulda)
* [factory_girl](http://github.com/thoughtbot/factory_girl)
* [faker](http://github.com/stympy/faker)
* [cucumber](http://github.com/aslakhellesoy/cucumber)
* [capybara](http://github.com/jnicklas/capybara)
* [pickle](https://github.com/ianwhite/pickle)

### Markup and styles
* [HAML](http://haml-lang.com/) as default template language
* [Compass](http://compass-style.org/) and related libraries to code your CSS: [fancy-buttons](https://github.com/imathis/fancy-buttons)
* A CSS framework on top of compass: Choose between [960 Grid System](http://960.gs/) and [Blueprint CSS](http://www.blueprintcss.org/)

### Other
* jQuery instead of Prototype
* [inherited_resources](https://github.com/josevalim/inherited_resources) to help you keep your controllers DRY
* [meta_search](https://github.com/ernie/meta_search)
* A rake task __'build'__ for continuous integration

Stuff it will let you choose from or opt-in
-------------------------------------------

### Authentication framework
* [Authlogic](https://github.com/binarylogic/authlogic)
* [Devise](https://github.com/plataformatec/devise)
* [Omniauth](https://github.com/intridea/omniauth)
* or skip this step

### Paginator
* [will_paginate](https://github.com/mislav/will_paginate)
* [Kaminari](https://github.com/amatsuda/kaminari)
* or skip this step

### Form builders
* [formtastic](https://github.com/justinfrench/formtastic) and [attrtastic](https://github.com/MBO/attrtastic) (default)
* [simple_form](https://github.com/plataformatec/simple_form) and [show_for](https://github.com/plataformatec/show_for)

### Deployment
* [Capistrano](https://github.com/capistrano/capistrano/) multistage ready to go: It will ask for the repo and server URLs for staging and production and configure your capistrano recipe so you can deploy to both environments from the very beginning
* [Heroku](http://heroku.com): It will prepare your repo for Heroku and it will create your staging and production apps and deploy if you want to.
* or skip this step

### Locales for i18n

Will ask for a list of locales and download them for you

### Permalinks

If you opt-in the template will install [friendly_id](https://github.com/norman/friendly_id) for you to deal with permalinks.

### Track errors
* [hoptoad_notifier](https://github.com/thoughtbot/hoptoad_notifier) to track application errors
* [exceptional](http://www.getexceptional.com/) to track your app's errors (this option is activated when deploying to heroku)

Contributions
=============

Feel free to fork the repo and send pull requests.

Issues
======

If you find bugs please report them in the issue tracker [here](https://github.com/aentos/rails3-templates/issues).

License
=======

The short version
-----------------

**Do you what you want.**

The long version
----------------

**MIT License**

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the 'Software'), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED 'AS IS', WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

