gulp = require 'gulp'
del = require 'del'
vinylPaths = require 'vinyl-paths'
haml = require 'gulp-haml'
coffee = require 'gulp-coffee'
sass = require 'gulp-sass'
plumber = require 'gulp-plumber'
notify = require 'gulp-notify'
zip = require 'gulp-zip'
manifest = require './src/manifest'

gulp.task 'clean', (cb) ->
  gulp.src 'dist'
    .pipe gulp.dest('dist')
    .pipe vinylPaths(del)

gulp.task 'copy:manifest', ->
  gulp.src 'src/manifest.json'
    .pipe gulp.dest('dist')

gulp.task 'copy:images', ->
  gulp.src 'src/images/*'
    .pipe gulp.dest('dist/images')

gulp.task 'copy:vendor', ->
  gulp.src 'vendor/**/*'
    .pipe gulp.dest('dist/vendor')

gulp.task 'haml', ->
  gulp.src 'src/haml/*.haml'
    .pipe plumber
      errorHandler: notify.onError('Error: <%= error.message %>')
    .pipe haml()
    .pipe gulp.dest('dist/html')

gulp.task 'coffee', ->
  gulp.src 'src/coffee/**/*.coffee'
    .pipe plumber
      errorHandler: notify.onError("Error: <%= error.message %>")
    .pipe coffee(bare: true)
    .pipe gulp.dest('dist/javascripts')

gulp.task 'sass', ->
  gulp.src 'src/sass/*.sass'
    .pipe plumber
      errorHandler: notify.onError("Error: <%= error.message %>")
    .pipe sass
      indentedSyntax: true
    .pipe gulp.dest('dist/stylesheets')

gulp.task 'build', ['clean', 'copy:manifest', 'copy:images', 'copy:vendor', 'haml', 'coffee', 'sass']

gulp.task 'watch', ->
  gulp.watch 'src/manifest.json', ['copy:manifest']
  gulp.watch 'src/images/*', ['copy:images']
  gulp.watch 'vendor/**/*', ['copy:vendor']
  gulp.watch 'src/haml/*.haml', ['haml']
  gulp.watch 'src/coffee/**/*.coffee', ['coffee']
  gulp.watch 'src/sass/*.sass', ['sass']

gulp.task 'zip', ['build'], ->
  gulp.src 'dist/*'
    .pipe zip("forkwell_for_chrome-#{manifest.version}.zip")
    .pipe gulp.dest('dist')

gulp.task 'default', ['build']
