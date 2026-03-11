import XCTest

final class ProfileViewModelTests: XCTestCase {
    var sut: ProfileViewModel!
    var mockArticleServices: MockArticleServices!

    override func setUp() {
        super.setUp()
        mockArticleServices = MockArticleServices()
        sut = ProfileViewModel(articleServices: mockArticleServices)
    }

    override func tearDown() {
        sut = nil
        mockArticleServices = nil
        super.tearDown()
    }

    func test_selectedAuthorArticle_success_updatesArticles() {
        mockArticleServices.getTrendingArticleResult = .success(TestData.trendingArticles)
        let params = ArticleListParams(author: "testauthor", limit: "10", offset: "0")

        sut.selectedAuthorArticle(parameters: params)

        let expectation = expectation(description: "getProfile articles")
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            XCTAssertNotNil(self.sut.selectedUserArticle)
            XCTAssertEqual(self.sut.selectedUserArticle?.articlesCount, 1)
            XCTAssertFalse(self.sut.isLoading)
            expectation.fulfill()
        }
        waitForExpectations(timeout: 1)
    }

    func test_selectedAuthorArticle_failure_stopsLoading() {
        mockArticleServices.getTrendingArticleResult = .failure(.NetworkErrorAPIError("Not found"))
        let params = ArticleListParams(limit: "10", offset: "0")

        sut.selectedAuthorArticle(parameters: params)

        let expectation = expectation(description: "profile failure")
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            XCTAssertNil(self.sut.selectedUserArticle)
            XCTAssertFalse(self.sut.isLoading)
            expectation.fulfill()
        }
        waitForExpectations(timeout: 1)
    }

    func test_selectedAuthor_defaultValue() {
        XCTAssertNotNil(sut.selectedAuthor)
    }
}
