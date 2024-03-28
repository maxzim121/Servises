import UIKit

typealias ServicesCompletion = (Result<ServicesResponse, Error>) -> Void

final class NetworkClient {
    private let urlSession = URLSession.shared
    private var servicesTask: URLSessionTask?
    static let shared = NetworkClient()
    
    func fetchServices(completion: @escaping ServicesCompletion) {
        assert(Thread.isMainThread)
        let request = servicesRequest()
        servicesTask = urlSession.object(urlSession: urlSession, for: request) { [weak self] (result: Result<ServicesResponse, Error>) in
            DispatchQueue.main.async {
                guard self != nil else {return}
                switch result {
                case .success(let weather):
                    completion(.success(weather))
                case .failure(let error):
                    completion(.failure(error))
                    assertionFailure("\(error)")
                }
            }
        }
    }
    
    func servicesRequest() -> URLRequest {
        URLRequest.makeHTTPRequest(
            httpMethod: "get"
        )
    }
}
