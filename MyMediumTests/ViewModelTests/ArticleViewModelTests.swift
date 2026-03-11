import XCTest

final class ArticleViewModelTests: XCTestCase {
    var sut: ArticleViewModel!
    var mockArticleServices: MockArticleServices!
    var mockCommentsServices: MockCommentsServices!
    var mockFavoritesServices: MockFavoritesServices!

    override func setUp() {
        super.setUp()
        mockArticleServices = MockArticleServices()
        mockCommentsServices = MockCommentsServices()
        mockFavoritesServices = MockFavoritesServices()
        mockArticleServices.getTrendingArticleResult = .success(TestData.emptyTrendingArticles)
        mockArticleServices.getTagsResult = .success(TestData.articleTag)
        sut = ArticleViewModel(
            articleServices: mockArticleServices,
            commentsServices: mockCommentsServices,
            favoritesServices: mockFavoritesServices
        )
    }

    override func tearDown() {
        sut = nil
        mockArticleServices = nil
        mockCommentsServices = nil
        mockFavoritesServices = nil
        super.tearDown()
    }

    func test_getArticles_success_appendsArticles() {
        mockArticleServices.getTrendingArticleResult = .success(TestData.trendingArticles)

        sut.getArticles()

        let expectation = expectation(description: "getArticles")
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            XCTAssertNotNil(self.sut.articleData)
            XCTAssertFalse(self.sut.isLoading)
            expectation.fulfill()
        }
        waitForExpectations(timeout: 1)
    }

    func test_getTags_success_updatesTagList() {
        let expectation = expectation(description: "getTags")
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            XCTAssertNotNil(self.sut.tagList)
            XCTAssertEqual(self.sut.tagList?.tags?.count, 3)
            expectation.fulfill()
        }
        waitForExpectations(timeout: 1)
    }

    func test_bookMarkArticle_success_returnsArticle() {
        mockFavoritesServices.bookMarkArticleResult = .success(TestData.favArticleRes)
        sut.selectedArticle = TestData.article

        let expectation = expectation(description: "bookMark")
        sut.bookMarkArticle { article, error in
            XCTAssertNotNil(article)
            XCTAssertNil(error)
            XCTAssertEqual(article?.favorited, true)
            expectation.fulfill()
        }
        waitForExpectations(timeout: 1)
    }

    func test_reloadArticles_resetsAndFetches() {
        mockArticleServices.getTrendingArticleResult = .success(TestData.trendingArticles)

        sut.reloadArticles()

        let expectation = expectation(description: "reload")
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            XCTAssertEqual(self.sut.flitterParameters.offset, "0")
            XCTAssertFalse(self.sut.isLoading)
            expectation.fulfill()
        }
        waitForExpectations(timeout: 1)
    }

    func test_updateSelectedArticle_updatesArticle() {
        sut.selectedArticle = TestData.article
        let updated = TestData.favoritedArticle

        sut.updateSelectedArticle(article: updated)

        XCTAssertEqual(sut.selectedArticle.favorited, true)
    }
}
