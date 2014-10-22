gulp = require 'gulp'
jade = require 'gulp-jade'
stylus = require 'gulp-stylus'
coffee = require 'gulp-coffee'
uglify = require 'gulp-uglify'
concat = require 'gulp-concat'
connect = require 'gulp-connect'
sourcemaps = require 'gulp-sourcemaps'

gulp.task 'connect', ->
	connect.server
		port: 1337
		livereload: on
		root: 'build'

gulp.task 'coffee', ->
	gulp.src 'src/coffee/*.coffee'
		.pipe sourcemaps.init()
			.pipe coffee().on 'error', (err) ->
				console.log 'coffee err'
			.pipe uglify()
			.pipe concat 'all.min.js'
		.pipe sourcemaps.write()
		.pipe gulp.dest 'build/js'
		.pipe do connect.reload

gulp.task 'jade', ->
	gulp.src 'src/jade/*.jade'
		.pipe do jade
		.pipe gulp.dest 'build'
		.pipe do connect.reload

gulp.task 'stylus', ->
	gulp.src 'src/stylus/*.styl'
		.pipe stylus
			compress: true
		.pipe gulp.dest 'build/css'
		.pipe do connect.reload

gulp.task 'watch', ->
	gulp.watch 'build/coffee/*.coffee', ['coffee']
	gulp.watch 'build/jade/*.jade', ['jade']
	gulp.watch 'build/stylus/*.styl', ['stylus']

gulp.task 'default', ['coffee', 'jade', 'stylus', 'connect', 'watch']
