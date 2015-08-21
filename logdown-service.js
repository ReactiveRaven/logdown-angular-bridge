angular.module(
    "aanimals.module.logdown.service.logdown",
    []
)
    .service("Logdown", function() {
        var logdown;

        if (
            typeof module !== "undefined" &&
            typeof module.exports !== "undefined" &&
            typeof require === "function"
        ) {
            logdown = require("logdown");
        } else {
            logdown = window.Logdown;
        }

        if (typeof logdown !== "function") {
            throw new Error("Logdown is not defined; did you include the logdown script?");
        }

        return logdown;
    });
