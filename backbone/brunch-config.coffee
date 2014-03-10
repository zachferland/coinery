exports.config =

  files:
    javascripts:
      joinTo:
        'javascripts/app.js': /^app/
        'javascripts/vendor.js': /^(?!app)/

    stylesheets:
      joinTo: 'css/app.css'
      order:
      	before: []
      	after: []

    templates:
      joinTo: 'javascripts/app.js'
