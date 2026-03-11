import Foundation
import Alamofire

protocol ArticleServicesProtocol {
    func getTrendingArticle(parameters: Parameters?, completion: @escaping (Result<TrendingArticles, NetworkError>) -> Void)
    func getSignalArticle(parameters: Parameters?, endpoint: String, completion: @escaping (Result<updateArticleResponse, NetworkError>) -> Void)
    func getTags(parameters: Parameters?, completion: @escaping (Result<ArticleTag, NetworkError>) -> Void)
    func getFeedArticle(parameters: Parameters?, completion: @escaping (Result<FeedArticle, NetworkError>) -> Void)
    func uploadArticle(parameters: Parameters?, completion: @escaping (Result<Article, NetworkError>) -> Void)
    func updateArticle(parameters: Parameters?, endpoint: String, completion: @escaping (Result<updateArticleResponse, NetworkError>) -> Void)
    func deleteAricle(parameters: Parameters?, endpoint: String, completion: @escaping (Result<String, NetworkError>) -> Void)
}

extension ArticleServices: ArticleServicesProtocol {}
