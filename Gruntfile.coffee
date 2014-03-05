module.exports = (grunt) ->

  grunt.initConfig
    pkg: grunt.file.readJSON 'package.json'

    browserify:
      dist:
        files:
          'public/test.js': ['app/assets/javascripts/**/*.coffee']
        options:
          transform: ['coffeeify']


  grunt.loadNpmTasks 'grunt-browserify'
  grunt.registerTask 'default', ['browserify']


