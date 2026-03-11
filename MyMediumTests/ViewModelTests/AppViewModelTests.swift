import XCTest

final class AppViewModelTests: XCTestCase {
    var sut: AppViewModel!

    override func setUp() {
        super.setUp()
        sut = AppViewModel()
    }

    override func tearDown() {
        sut = nil
        super.tearDown()
    }

    func test_toggle_flipsShowState() {
        XCTAssertFalse(sut.show)
        sut.toggle()
        XCTAssertTrue(sut.show)
    }

    func test_errorMessage_triggersShowAlert() {
        XCTAssertFalse(sut.showAlert)
        sut.errorMessage = "Error occurred"
        XCTAssertTrue(sut.showAlert)
        XCTAssertEqual(sut.errorMessage, "Error occurred")
    }
}
