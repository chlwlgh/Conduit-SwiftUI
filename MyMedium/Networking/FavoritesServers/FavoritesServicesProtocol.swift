import Foundation
import Alamofire

protocol FavoritesServicesProtocol {
    func bookMarkArticle(parameters: Parameters?, endpoint: String, completion: @escaping (Result<FavArticleRes, NetworkError>) -> Void)
    func removeBookMarkArticle(parameters: Parameters?, endpoint: String, completion: @escaping (Result<FavArticleRes, NetworkError>) -> Void)
}

extension FavoritesServices: FavoritesServicesProtocol {}
