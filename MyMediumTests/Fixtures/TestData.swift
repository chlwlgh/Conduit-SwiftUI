import Foundation

enum TestData {
    static let user = User(
        email: "test@example.com",
        token: "test-jwt-token",
        username: "testuser",
        bio: "Test bio",
        image: "https://example.com/image.png"
    )

    static let loginSuccess = LoginSuccess(user: user)

    static let author = Author(
        username: "testauthor",
        bio: "Author bio",
        image: "https://example.com/author.png",
        following: false
    )

    static let article = Article(
        slug: "test-article-slug",
        title: "Test Article Title",
        description: "Test description",
        body: "Test article body content",
        tagList: ["swift", "test"],
        favoriteBy: [],
        createdAt: "2023-01-01T00:00:00.000Z",
        updatedAt: "2023-01-01T00:00:00.000Z",
        favorited: false,
        favoritesCount: 5,
        author: author
    )

    static let favoritedArticle = Article(
        slug: "test-article-slug",
        title: "Test Article Title",
        description: "Test description",
        body: "Test article body content",
        tagList: ["swift", "test"],
        favoriteBy: [],
        createdAt: "2023-01-01T00:00:00.000Z",
        updatedAt: "2023-01-01T00:00:00.000Z",
        favorited: true,
        favoritesCount: 6,
        author: author
    )

    static let trendingArticles = TrendingArticles(
        articles: [article],
        articlesCount: 1
    )

    static let emptyTrendingArticles = TrendingArticles(
        articles: [],
        articlesCount: 0
    )

    static let feedArticle = FeedArticle(
        articles: [article],
        articlesCount: 1
    )

    static let emptyFeedArticle = FeedArticle(
        articles: [],
        articlesCount: 0
    )

    static let articleTag = ArticleTag(
        tags: ["swift", "ios", "swiftui"]
    )

    static let comment = Comment(
        id: 1,
        createdAt: "2023-01-01T00:00:00.000Z",
        updatedAt: "2023-01-01T00:00:00.000Z",
        body: "Test comment body",
        author: author
    )

    static let commentListResponse = CommentListResponse(
        comments: [comment]
    )

    static let commentResponse = CommentResponse(
        comments: comment
    )

    static let profile = Profile(
        username: "testauthor",
        bio: "Author bio",
        image: "https://example.com/author.png",
        following: false
    )

    static let followedProfile = Profile(
        username: "testauthor",
        bio: "Author bio",
        image: "https://example.com/author.png",
        following: true
    )

    static let followUser = FollowUser(profile: profile)
    static let followedUser = FollowUser(profile: followedProfile)

    static let favArticleRes = FavArticleRes(article: favoritedArticle)
    static let updateArticleRes = updateArticleResponse(article: article)
}
