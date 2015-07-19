var gulp = require("gulp");
var path = require("path");

var paths = {
    js: [ "./logdown-service.js" ]
};

gulp.task("default", [ "test" ]);

gulp.task("test", ["karma-unit"]);

gulp.task("watch", function () {
    var watch = require("gulp-watch");

    gulp.start("karma-unit");

    watch(paths.js, function () {
        gulp.start("karma-unit");
    });
});

gulp.task("karma-unit", [ "jshint", "karma-unit-bare" ], function (done) {
    done(); // just a convenience task
});

gulp.task("karma-unit-bare", function (done) {
    var karma = require("karma");
    var Server = karma.Server;

    new Server({
        configFile: __dirname + "/test/karma.conf.js",
        action: "run",
        singleRun: true
    }, done).start();
});

gulp.task("jshint", function () {
    var jshint = require("gulp-jshint");

    return gulp.src(paths.js)
        .pipe(jshint())
        .pipe(jshint.reporter())
        .pipe(jshint.reporter("fail"));
});
