## Coinery ##
A BTC-denominated storefront for buying & selling your digital goods. Created as part of the 2014 BitHack


![Codeship Status](https://www.codeship.io/projects/0a863a40-8ea9-0131-5850-32c0590fdc55/status)


#### App structure ####

**Rails + Backbone living together in relative harmony.**

The Backbone app is completely separate from the rails app and can be found in the `backbone/` dir.
The Rails app is configured to serve public assets from `backbone/public/`

```
backbone/
|-- app/
|   |-- router.coffee
|   |-- app.coffee
|   |-- init.coffee
|   |-- models/
|   |   |-- user.coffee
|   |   |-- product.coffee
|   |-- collections/
|   |   |-- products.coffee
|   |-- templates/
|   |   |-- nav.hbs
|   |   |-- footer.hbs
|   |-- assets/
|   |   |-- index.html
|   |   |-- img/
|   |   |-- css/
|   |-- sass/
|   |   |-- app.sass
|   |   |-- _partial.sass
|-- public/
|   |-- index.html
|   |-- img/
|   |-- css/
|   |-- js/
```

We compile coffeescript and sass and build the webapp with a handy tool called Brunch (http://brunch.io/)
Brunch uses Bower for js dependency management.


__Running the app locally__

Install necessary gems
```
$ bundle install
```
Install compass locally 
```
gem install compass
```

Install node.js (which comes with npm automatically) if not already installed
```
$ brew install node
```

Add node to your $PATH in ~/.bash_profile, ~/.zshrc or wherever your terminal configs sit if not already added
```
export PATH=/usr/local/bin/node_modules:$PATH
export PATH=/usr/local/bin/node:$PATH
```

Start the thin server
```
$ thin start
```

Install Brunch and Bower (specified in `package.json`)
```
$ cd backbone
$ npm install bower -g
$ npm install brunch -g
```

Fetch JS dependencies with Bower (one time only)
```
$ bower install
```

Build the webapp with Brunch and monitor for changes
```
$ brunch build
$ brunch watch
```

The webapp should now be running at localhost:3000


__Using Node/CommonJS modules in Backbone__

A module is a discrete unit of code with a well defined interface.

When using CommonJS modules, every file has dependencies (require statements) and exports:

Example:

```coffeescript
# in house.coffee

Lamp = require('lamp')

enter = () ->
  Lamp.on()

leave = () ->
  Lamp.off()

module.exports =
  'enter': enter
  'leave': leave
```

Here's an example of a few discrete Backbone modules

```coffeescript
# in models/user.coffee

Product = require 'models/product'

module.exports = Class User extends Backbone.Model

  url: ''

  initialize: ->
    sample = new Product
      price: '12'
      name: 'Ebook'

    @set 'products', [sample,]

# in views/login.coffee

User = require 'models/user'

module.exports = Class LoginView extends Backbone.View

  events:
    'submit form': 'loginHandler'

  loginHandler: (e) ->
    @user = new User()
    @user.fetch

```

http://nodejs.org/docs/latest/api/modules.html#modules_modules
