import UIKit

public final class ViewModuleAssembly {
    public func build() -> UIViewController {
        let presenter = ViewControllerPresenter()
        let viewController = ViewController(presenter: presenter)
        return viewController
    }
}
