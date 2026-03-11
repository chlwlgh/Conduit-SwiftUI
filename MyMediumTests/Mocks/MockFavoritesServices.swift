import Foundation
import Alamofire

class MockFavoritesServices: FavoritesServicesProtocol {
    var bookMarkArticleResult: Result<FavArticleRes, NetworkError> = .failure(.NoData)
    var removeBookMarkArticleResult: Result<FavArticleRes, NetworkError> = .failure(.NoData)

    func bookMarkArticle(parameters: Parameters?, endpoint: String, completion: @escaping (Result<FavArticleRes, NetworkError>) -> Void) {
        completion(bookMarkArticleResult)
    }

    func removeBookMarkArticle(parameters: Parameters?, endpoint: String, completion: @escaping (Result<FavArticleRes, NetworkError>) -> Void) {
        completion(removeBookMarkArticleResult)
    }
}
