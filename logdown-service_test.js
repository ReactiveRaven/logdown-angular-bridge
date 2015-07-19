describe("aanimals.module.logdown.service.logdown", function() {
    var $log;
    var Logdown;

    beforeEach(function() {
        module("aanimals.module.logdown.service.logdown");

        inject(function(_$log_, _Logdown_) {
            $log = _$log_;
            Logdown = _Logdown_;
        });
    });

    describe("Logdown", function() {
        it("should be a function", function() {
            expect(Logdown).toEqual(jasmine.any(Function));
        });
    });

    describe("$log", function() {
    });

});
