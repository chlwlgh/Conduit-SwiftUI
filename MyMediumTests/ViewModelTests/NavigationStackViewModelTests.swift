import XCTest
import SwiftUI

final class NavigationStackViewModelTests: XCTestCase {

    func test_feedNavigation_initiallyEmpty() {
        let sut = FeedNavigationStackViewModal()
        XCTAssertTrue(sut.presentedScreen.isEmpty)
    }

    func test_tradingNavigation_initiallyEmpty() {
        let sut = TradingNavigationStackViewModal()
        XCTAssertTrue(sut.presentedScreen.isEmpty)
    }

    func test_profileNavigation_initiallyEmpty() {
        let sut = ProfileNavigationStackViewModal()
        XCTAssertTrue(sut.presentedScreen.isEmpty)
    }

    func test_feedNavigation_pushAndPop() {
        let sut = FeedNavigationStackViewModal()
        sut.presentedScreen.append("detail")
        XCTAssertFalse(sut.presentedScreen.isEmpty)
        XCTAssertEqual(sut.presentedScreen.count, 1)

        sut.presentedScreen.removeLast()
        XCTAssertTrue(sut.presentedScreen.isEmpty)
    }
}
