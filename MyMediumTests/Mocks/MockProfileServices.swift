import Foundation
import Alamofire

class MockProfileServices: ProfileServicesProtocol {
    var requestFollowResult: Result<FollowUser, NetworkError> = .failure(.NoData)
    var removeFollowResult: Result<FollowUser, NetworkError> = .failure(.NoData)

    func requestFollow(parameters: Parameters?, endpoint: String, completion: @escaping (Result<FollowUser, NetworkError>) -> Void) {
        completion(requestFollowResult)
    }

    func removeFollow(parameters: Parameters?, endpoint: String, completion: @escaping (Result<FollowUser, NetworkError>) -> Void) {
        completion(removeFollowResult)
    }
}
