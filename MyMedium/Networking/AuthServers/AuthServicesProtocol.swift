import Foundation
import Alamofire

protocol AuthServicesProtocol {
    func userLogin(parameters: Parameters?, completion: @escaping (Result<LoginSuccess, NetworkError>) -> Void)
    func createAccount(parameters: Parameters?, completion: @escaping (Result<CreateAccountResponse, NetworkError>) -> Void)
    func getUser(parameters: Parameters?, completion: @escaping (Result<LoginSuccess, NetworkError>) -> Void)
    func updateAccount(parameters: Parameters?, completion: @escaping (Result<LoginSuccess, NetworkError>) -> Void)
}

extension AuthServices: AuthServicesProtocol {}
