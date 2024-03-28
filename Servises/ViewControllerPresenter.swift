import Foundation

protocol ViewControllerPresenterProtocol: AnyObject {
    func viewController(viewController: ViewController)
    func getServices() -> [Service]
    func getServicesCount() -> Int
}

final class ViewControllerPresenter {
    
    let networkClient = NetworkClient.shared
    var services: [Service]?
    
    weak var view: ViewControllerProtocol?
    
    private func fetchServices() {
        networkClient.fetchServices() { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let response):
                self.services = response.body.services
                self.view?.reloadData()
            case .failure(let error):
                assertionFailure("\(error)")
            }
        }
    }
    
}

extension ViewControllerPresenter: ViewControllerPresenterProtocol {
    
    func getServicesCount() -> Int {
        guard let services = services else { return 0}
        return services.count
    }
    
    func viewController(viewController: ViewController) {
        view = viewController
        fetchServices()
    }
    
    func getServices() -> [Service] {
        guard let services = services else { return []}
        return services
    }
}
