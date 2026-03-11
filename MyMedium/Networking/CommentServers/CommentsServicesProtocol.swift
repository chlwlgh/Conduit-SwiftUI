import Foundation
import Alamofire

protocol CommentsServicesProtocol {
    func getComments(parameters: Parameters?, endpoint: String, completion: @escaping (Result<CommentListResponse, NetworkError>) -> Void)
    func addComment(parameters: Parameters?, endpoint: String, completion: @escaping (Result<CommentResponse, NetworkError>) -> Void)
    func deleteComment(parameters: Parameters?, endpoint: String, costumeCompletion: ((HTTPURLResponse?) -> Void)?, completion: @escaping (Result<String, NetworkError>) -> Void)
}

extension CommentsServices: CommentsServicesProtocol {}
