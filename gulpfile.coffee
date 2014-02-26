gulp        = require 'gulp'
less        = require 'gulp-less'
concatCSS   = require 'gulp-concat-css'
minifyCSS   = require 'gulp-minify-css'
rename      = require 'gulp-rename'
concat      = require 'gulp-concat'
uglify      = require 'gulp-uglify'
livereload  = require 'gulp-livereload'
clean       = require 'gulp-clean'
watch       = require 'gulp-watch'
plumber     = require 'gulp-plumber'
filelog     = require 'gulp-filelog'
notify      = require 'gulp-notify'


dir = 
  less      : 'less'
  css       : 'css'
  pages     : 'docs'
  img       : 'img'
  js        : 'js'



gulp.task 'images', ->
  gulp.src([
      dir.img+'/*.png'
      dir.img+'/*.jpg'
      dir.img+'/*.gif'
    ])
    # .pipe watch()
    # .pipe plumber()
    .pipe livereload()
    .pipe filelog()
    .pipe notify('-- IMAGES')


gulp.task 'pages', ->
  gulp.src(dir.pages+'/**/*.md')
    # .pipe watch()
    # .pipe plumber()
    .pipe livereload()
    .pipe filelog()
    .pipe notify('-- PAGES')


gulp.task 'php', ->
  gulp.src(['*php', 'libs/*.php'])
    # .pipe watch()
    # .pipe plumber()
    .pipe livereload()
    .pipe filelog()
    .pipe notify('-- PHP')


gulp.task 'scripts', ->
  gulp.src(dir.js+'/src/*.js')
    # .pipe watch()
    # .pipe plumber()
    .pipe concat('all.js')
    .pipe gulp.dest(dir.js)
    # .pipe clean()
    .pipe rename('all.min.js')
    .pipe uglify()
    .pipe gulp.dest(dir.js)
    .pipe livereload()
    .pipe filelog()
    .pipe notify('-- SCRIPTS')

gulp.task 'less', ->
  gulp.src(dir.less+'/*.less')
    # .pipe watch()
    # .pipe plumber()
    .pipe less()
    .pipe concatCSS('all.css')
    .pipe gulp.dest(dir.css)
    .pipe minifyCSS()
    .pipe rename('all.min.css')
    .pipe gulp.dest(dir.css)
    .pipe livereload()
    .pipe filelog()
    .pipe notify('-- LESS')


gulp.task 'default', [
  'images'
  'pages'
  'scripts'
  'less'
  'php'
]