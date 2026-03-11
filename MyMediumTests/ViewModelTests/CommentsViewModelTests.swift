import XCTest

final class CommentsViewModelTests: XCTestCase {
    var sut: CommentsViewModel!

    override func setUp() {
        super.setUp()
        sut = CommentsViewModel()
    }

    override func tearDown() {
        sut = nil
        super.tearDown()
    }

    func test_toggle_flipsShowState() {
        XCTAssertFalse(sut.show)
        sut.toggle()
        XCTAssertTrue(sut.show)
        sut.toggle()
        XCTAssertFalse(sut.show)
    }

    func test_errorMessage_triggersShowAlert() {
        XCTAssertFalse(sut.showAlert)
        sut.errorMessage = "Something went wrong"
        XCTAssertTrue(sut.showAlert)
        XCTAssertEqual(sut.errorMessage, "Something went wrong")
    }

    func test_errorMessage_togglesAlert_eachTime() {
        sut.errorMessage = "Error 1"
        XCTAssertTrue(sut.showAlert)
        sut.errorMessage = "Error 2"
        XCTAssertFalse(sut.showAlert)
    }
}
