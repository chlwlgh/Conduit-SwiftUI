import XCTest

final class FeedArticleViewModelTests: XCTestCase {
    var sut: FeedArticleViewModel!
    var mockArticleServices: MockArticleServices!

    override func setUp() {
        super.setUp()
        mockArticleServices = MockArticleServices()
        mockArticleServices.getFeedArticleResult = .success(TestData.emptyFeedArticle)
        sut = FeedArticleViewModel(articleServices: mockArticleServices)
    }

    override func tearDown() {
        sut = nil
        mockArticleServices = nil
        super.tearDown()
    }

    func test_getArticles_success_appendsArticles() {
        mockArticleServices.getFeedArticleResult = .success(TestData.feedArticle)

        sut.getArticles()

        let expectation = expectation(description: "getFeed")
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            XCTAssertNotNil(self.sut.articleData)
            XCTAssertFalse(self.sut.isLoading)
            expectation.fulfill()
        }
        waitForExpectations(timeout: 1)
    }

    func test_getArticles_empty_result() {
        mockArticleServices.getFeedArticleResult = .success(TestData.emptyFeedArticle)

        sut.reloadArticles()

        let expectation = expectation(description: "empty feed")
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            XCTAssertEqual(self.sut.articleData?.articlesCount, 0)
            XCTAssertFalse(self.sut.isLoading)
            expectation.fulfill()
        }
        waitForExpectations(timeout: 1)
    }

    func test_getArticles_failure_stopsLoading() {
        mockArticleServices.getFeedArticleResult = .failure(.NetworkErrorAPIError("Network error"))

        sut.getArticles()

        let expectation = expectation(description: "error feed")
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            XCTAssertFalse(self.sut.isLoading)
            expectation.fulfill()
        }
        waitForExpectations(timeout: 1)
    }
}
