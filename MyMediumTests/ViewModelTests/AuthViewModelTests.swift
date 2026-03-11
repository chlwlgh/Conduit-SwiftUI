import XCTest

final class AuthViewModelTests: XCTestCase {
    var sut: AuthViewModel!
    var mockAuthServices: MockAuthServices!
    var mockArticleServices: MockArticleServices!

    override func setUp() {
        super.setUp()
        mockAuthServices = MockAuthServices()
        mockArticleServices = MockArticleServices()
        mockAuthServices.getUserResult = .failure(.NoData)
        sut = AuthViewModel(authServices: mockAuthServices, articleServices: mockArticleServices)
    }

    override func tearDown() {
        sut = nil
        mockAuthServices = nil
        mockArticleServices = nil
        super.tearDown()
    }

    func test_getProfile_success_updatesUserState() {
        mockAuthServices.getUserResult = .success(TestData.loginSuccess)

        sut.getProfile()

        let expectation = expectation(description: "getProfile")
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            XCTAssertNotNil(self.sut.userState)
            XCTAssertEqual(self.sut.userState?.user?.username, "testuser")
            XCTAssertTrue(self.sut.isLoggedIn)
            XCTAssertFalse(self.sut.isLoading)
            expectation.fulfill()
        }
        waitForExpectations(timeout: 1)
    }

    func test_getProfile_failure_clearsUserState() {
        mockAuthServices.getUserResult = .failure(.NetworkErrorAPIError("Unauthorized"))

        sut.getProfile()

        let expectation = expectation(description: "getProfile failure")
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            XCTAssertNil(self.sut.userState)
            XCTAssertFalse(self.sut.isLoggedIn)
            XCTAssertFalse(self.sut.isLoading)
            expectation.fulfill()
        }
        waitForExpectations(timeout: 1)
    }

    func test_getArticles_success_updatesUserArticle() {
        mockArticleServices.getTrendingArticleResult = .success(TestData.trendingArticles)
        let params = ArticleListParams(limit: "10", offset: "0")

        sut.getArticles(parameters: params)

        let expectation = expectation(description: "getArticles")
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            XCTAssertNotNil(self.sut.userArticle)
            XCTAssertEqual(self.sut.userArticle?.articlesCount, 1)
            XCTAssertFalse(self.sut.isLoading)
            expectation.fulfill()
        }
        waitForExpectations(timeout: 1)
    }

    func test_saveUser_updatesUserState() {
        let loginSuccess = TestData.loginSuccess
        sut.saveUser(data: loginSuccess)

        XCTAssertNotNil(sut.userState)
        XCTAssertEqual(sut.userState?.user?.email, "test@example.com")
    }
}
