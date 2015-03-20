gulp = require 'gulp'
del = require 'del'
haml = require 'gulp-haml'
coffee = require 'gulp-coffee'
sass = require 'gulp-sass'
plumber = require 'gulp-plumber'
notify = require 'gulp-notify'
zip = require 'gulp-zip'
manifest = require './src/manifest'

gulp.task 'clean', (cb) ->
  del 'dist', cb

gulp.task 'copy:manifest', ['clean'], ->
  gulp.src 'src/manifest.json'
    .pipe gulp.dest('dist')

gulp.task 'copy:images', ['clean'], ->
  gulp.src 'src/images/*'
    .pipe gulp.dest('dist/images')

gulp.task 'copy:vendor', ['clean'], ->
  gulp.src 'vendor/**/*'
    .pipe gulp.dest('dist/vendor')

gulp.task 'haml', ['clean'], ->
  gulp.src 'src/haml/*.haml'
    .pipe plumber
      errorHandler: notify.onError('Error: <%= error.message %>')
    .pipe haml()
    .pipe gulp.dest('dist/html')

gulp.task 'coffee', ['clean'], ->
  gulp.src 'src/coffee/**/*.coffee'
    .pipe plumber
      errorHandler: notify.onError("Error: <%= error.message %>")
    .pipe coffee(bare: true)
    .pipe gulp.dest('dist/javascripts')

gulp.task 'sass', ['clean'], ->
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
  console.log "v#{manifest.version}"

gulp.task 'zip', ['build'], ->
  gulp.src 'dist/**/*'
    .pipe zip("dist-v#{manifest.version}.zip")
    .pipe gulp.dest('.')

gulp.task 'default', ['watch', 'build']
