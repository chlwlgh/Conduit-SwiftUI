import Foundation
import Alamofire

protocol ProfileServicesProtocol {
    func requestFollow(parameters: Parameters?, endpoint: String, completion: @escaping (Result<FollowUser, NetworkError>) -> Void)
    func removeFollow(parameters: Parameters?, endpoint: String, completion: @escaping (Result<FollowUser, NetworkError>) -> Void)
}

extension ProfileServices: ProfileServicesProtocol {}
