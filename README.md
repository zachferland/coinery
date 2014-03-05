== Coinery
A BTC-denominated storefront for buying & selling your digital goods. Created as part of the 2014 BitHack

### Compiling front-end assets ###

Please chime in with any improvements...

The Backbone app root is located in /app/assets/javascripts
Compass files will be located in /app/assets/stylesheets (?)

Sample backbone structure

```
|-- libs
|   |-- jquery.min.js
|   |-- backbone.min.js
|   |-- underscore.min.js
|-- models
|   |-- user.coffee
|   |-- product.coffee
|-- collections
|   |-- products.coffee
|-- templates
|   |-- header.hbs
|   |-- footer.hbs
|-- router.coffee
|-- app.coffee
|-- main.coffee
```

In CommonJS, every file has dependencies (require statements) and exports.

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

The build process looks like this:
- Browserify generates main.js file using CommonJS modules
- Grunt precompiles handlebars (*.hbs) templates
- Grunt concats libs, main.js and precompiled handlebars templates into one application.js file
- Grunt uses compass to compile sass files into one app.css file

^^ this logic will be in Gruntfile.coffee

to start the build process, simply run

```
$ npm install
```

once, then

```
grunt watch
```

this will watch the files in /app/assets/ and automatically run the build process on a change

Grab the LiveReload chrome extension for live, automagic browser refreshes: https://chrome.google.com/webstore/detail/livereload/jnihajbhpnppcggbcgedagnkighmdlei?hl=en


















