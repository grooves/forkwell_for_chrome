require('dotenv').load()

gulp = require 'gulp'
del = require 'del'
haml = require 'gulp-haml'
coffee = require 'gulp-coffee'
sass = require 'gulp-sass'
plumber = require 'gulp-plumber'
notify = require 'gulp-notify'
zip = require 'gulp-zip'
jeditor = require 'gulp-json-editor'
browserify = require 'browserify'
source = require 'vinyl-source-stream'
buffer = require 'vinyl-buffer'

version = require('./package.json').version

gulp.task 'clean', (cb) ->
  del 'dist', cb

gulp.task 'copy:manifest', ->
  gulp.src 'src/manifest.json'
    .pipe jeditor (json) ->
      json.version = version
      json.permissions.push process.env.FORKWELL_HOST if process.env.FORKWELL_HOST
      json
    .pipe gulp.dest('dist')

gulp.task 'copy:images', ->
  del.sync 'dist/images'
  gulp.src 'src/images/*'
    .pipe gulp.dest('dist/images')

gulp.task 'copy:vendor', ->
  del.sync 'dist/vendor'
  gulp.src 'vendor/**/*'
    .pipe gulp.dest('dist/vendor')

gulp.task 'haml', ->
  del.sync 'dist/html'
  gulp.src 'src/haml/*.haml'
    .pipe plumber
      errorHandler: notify.onError('Error: <%= error.message %>')
    .pipe haml()
    .pipe gulp.dest('dist/html')

gulp.task 'coffee', ['coffee:background', 'coffee:popup']

gulp.task 'coffee:background', ->
  browserify
    entries: './src/coffee/background.coffee'
    extensions: ['.coffee']
  .transform 'coffeeify'
  .bundle()
  .pipe source('background.js')
  .pipe gulp.dest('dist/javascripts')

gulp.task 'coffee:popup', ->
  browserify
    entries: './src/coffee/popup.coffee'
    extensions: ['.coffee']
  .transform 'coffeeify'
  .bundle()
  .pipe source('popup.js')
  .pipe gulp.dest('dist/javascripts')

gulp.task 'sass', ->
  del.sync 'dist/stylesheets'
  gulp.src 'src/sass/*.sass'
    .pipe plumber
      errorHandler: notify.onError("Error: <%= error.message %>")
    .pipe sass
      indentedSyntax: true
    .pipe gulp.dest('dist/stylesheets')

gulp.task 'build', ['copy:manifest', 'copy:images', 'copy:vendor', 'haml', 'coffee', 'sass']

gulp.task 'watch', ->
  gulp.watch 'src/manifest.json', ['copy:manifest']
  gulp.watch 'src/images/*', ['copy:images']
  gulp.watch 'vendor/**/*', ['copy:vendor']
  gulp.watch 'src/haml/*.haml', ['haml']
  gulp.watch 'src/coffee/**/*.coffee', ['coffee']
  gulp.watch 'src/sass/*.sass', ['sass']

gulp.task 'app_version', ->
  console.log "v#{version}"

gulp.task 'zip', ['build'], ->
  gulp.src 'dist/**/*'
    .pipe zip("dist-v#{version}.zip")
    .pipe gulp.dest('.')

gulp.task 'default', ['watch', 'build']
