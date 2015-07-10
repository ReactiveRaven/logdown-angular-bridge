angular.module(
    "aanimals.module.logdown.service.logdown",
    []
)
    .service("Logdown", function() {
        if (typeof Logdown !== "function") {
            throw new Error("Logdown is not defined; did you include the logdown script?");
        }
        return Logdown;
    });
