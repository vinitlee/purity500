module.exports = (grunt) ->
  grunt.initConfig
    pkg: grunt.file.readJSON('package.json')
    coffee: 
      glob_to_multiple:
        expand: true
        flatten: true
        cwd: 'src/scripts'
        src: [ '*.coffee' ]
        dest: 'public/scripts'
        ext: '.js'
    stylus:
      compile:
        options:
          # paths: ['src/stylesheets'],
          urlfumc: 'embedurl',
        files:
          'public/styles/main.css':'src/styles/main.styl'
    watch:
      scripts:
        files: ['src/**/*.coffee']
        tasks: ['scripts']
      styles:
        files: ['src/**/*.styl']
        tasks: ['styles']


  grunt.loadNpmTasks 'grunt-contrib-coffee'
  grunt.loadNpmTasks 'grunt-contrib-stylus'

  grunt.loadNpmTasks 'grunt-contrib-watch'

  grunt.registerTask 'scripts', [ 'coffee' ]
  grunt.registerTask 'styles', [ 'stylus' ]

  grunt.registerTask 'default', [ 'coffee' ]