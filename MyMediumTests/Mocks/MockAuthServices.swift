import Foundation
import Alamofire

class MockAuthServices: AuthServicesProtocol {
    var userLoginResult: Result<LoginSuccess, NetworkError> = .failure(.NoData)
    var createAccountResult: Result<CreateAccountResponse, NetworkError> = .failure(.NoData)
    var getUserResult: Result<LoginSuccess, NetworkError> = .failure(.NoData)
    var updateAccountResult: Result<LoginSuccess, NetworkError> = .failure(.NoData)

    func userLogin(parameters: Parameters?, completion: @escaping (Result<LoginSuccess, NetworkError>) -> Void) {
        completion(userLoginResult)
    }

    func createAccount(parameters: Parameters?, completion: @escaping (Result<CreateAccountResponse, NetworkError>) -> Void) {
        completion(createAccountResult)
    }

    func getUser(parameters: Parameters?, completion: @escaping (Result<LoginSuccess, NetworkError>) -> Void) {
        completion(getUserResult)
    }

    func updateAccount(parameters: Parameters?, completion: @escaping (Result<LoginSuccess, NetworkError>) -> Void) {
        completion(updateAccountResult)
    }
}
