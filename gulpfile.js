"use strict";

var gulp = require('gulp'),
    spawn = require('child_process').spawn,
    concat = require('gulp-concat'),
    node;

var directories = {
    "api": {
        "source": "src/api/**/*.js",
        "dest": "build/api"
    }
};

function apiServer() {
    if (node) {
        node.kill();
    }
    node = spawn('node', ['build/api/server.js'], {stdio: 'inherit'});
    node.on('close', function (code) {
        if (code === 8) {
            gulp.log('Error detected, waiting for changes...');
        }
    });
}


gulp.task('api-js', function () {
    return gulp.src(directories.api.source)
        .pipe(gulp.dest(directories.api.dest));
});

gulp.task('watch', function () {
    var watchers = {};
    watchers.api = gulp.watch(directories.api.source, ['api-js']);
    watchers.api.on('change', function(event) {
        apiServer();
    });
});
