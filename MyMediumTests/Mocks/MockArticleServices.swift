import Foundation
import Alamofire

class MockArticleServices: ArticleServicesProtocol {
    var getTrendingArticleResult: Result<TrendingArticles, NetworkError> = .failure(.NoData)
    var getSignalArticleResult: Result<updateArticleResponse, NetworkError> = .failure(.NoData)
    var getTagsResult: Result<ArticleTag, NetworkError> = .failure(.NoData)
    var getFeedArticleResult: Result<FeedArticle, NetworkError> = .failure(.NoData)
    var uploadArticleResult: Result<Article, NetworkError> = .failure(.NoData)
    var updateArticleResult: Result<updateArticleResponse, NetworkError> = .failure(.NoData)
    var deleteAricleResult: Result<String, NetworkError> = .failure(.NoData)

    func getTrendingArticle(parameters: Parameters?, completion: @escaping (Result<TrendingArticles, NetworkError>) -> Void) {
        completion(getTrendingArticleResult)
    }

    func getSignalArticle(parameters: Parameters?, endpoint: String, completion: @escaping (Result<updateArticleResponse, NetworkError>) -> Void) {
        completion(getSignalArticleResult)
    }

    func getTags(parameters: Parameters?, completion: @escaping (Result<ArticleTag, NetworkError>) -> Void) {
        completion(getTagsResult)
    }

    func getFeedArticle(parameters: Parameters?, completion: @escaping (Result<FeedArticle, NetworkError>) -> Void) {
        completion(getFeedArticleResult)
    }

    func uploadArticle(parameters: Parameters?, completion: @escaping (Result<Article, NetworkError>) -> Void) {
        completion(uploadArticleResult)
    }

    func updateArticle(parameters: Parameters?, endpoint: String, completion: @escaping (Result<updateArticleResponse, NetworkError>) -> Void) {
        completion(updateArticleResult)
    }

    func deleteAricle(parameters: Parameters?, endpoint: String, completion: @escaping (Result<String, NetworkError>) -> Void) {
        completion(deleteAricleResult)
    }
}
