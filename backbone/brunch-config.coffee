exports.config =

  files:
    javascripts:
      joinTo:
        'javascripts/app.js': /^app(\/|\\)(?!overlay)/
        'javascripts/overlay.js': /^app(\/|\\)overlay/
        'javascripts/vendor.js': /^(?!app)/

    stylesheets:
      joinTo: 'css/app.css'
      joinTo:
        'css/app.css': /^app\/sass\/app/
        'css/overlay.css': /^app\/sass\/overlay/

      order:
      	before: []
      	after: []

    templates:
      joinTo: 'javascripts/app.js'
