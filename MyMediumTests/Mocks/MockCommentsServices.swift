import Foundation
import Alamofire

class MockCommentsServices: CommentsServicesProtocol {
    var getCommentsResult: Result<CommentListResponse, NetworkError> = .failure(.NoData)
    var addCommentResult: Result<CommentResponse, NetworkError> = .failure(.NoData)
    var deleteCommentResult: Result<String, NetworkError> = .failure(.NoData)

    func getComments(parameters: Parameters?, endpoint: String, completion: @escaping (Result<CommentListResponse, NetworkError>) -> Void) {
        completion(getCommentsResult)
    }

    func addComment(parameters: Parameters?, endpoint: String, completion: @escaping (Result<CommentResponse, NetworkError>) -> Void) {
        completion(addCommentResult)
    }

    func deleteComment(parameters: Parameters?, endpoint: String, costumeCompletion: ((HTTPURLResponse?) -> Void)?, completion: @escaping (Result<String, NetworkError>) -> Void) {
        completion(deleteCommentResult)
    }
}
