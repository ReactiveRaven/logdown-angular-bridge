module.exports = function(config) {
  config.set({

    basePath: "../",

    files: [
      "bower_components/angular/angular.min.js",
      "bower_components/angular-mocks/angular-mocks.js",
      "bower_components/logdown/dist/index.js",
      "logdown-service.js",
      "logdown-service_test.js"
    ],

    autoWatch: true,

    exclude: [
    ],

    frameworks: [ "jasmine" ],

    reporters: [ "progress", "coverage" ],

    browsers: [ "PhantomJS" ],

    plugins: [
      "karma-phantomjs-launcher",
      "karma-jasmine",
      "karma-coverage"
    ],

    preprocessors: {
      "logdown-service.js": [ "coverage" ],
    },

    coverageReporter: {
        dir: "./test/karma-coverage/",
        reporters: [
            { type: "text-summary", subdir: "." },
            { type: "text-summary", subdir: ".", file: "coverage-summary.txt" },
            { type: "html", subdir: "." },
            { type: "lcov", subdir: "lcov" },
            { type: "cobertura", subdir: "cobertura" }
        ]
    }
  });
};
