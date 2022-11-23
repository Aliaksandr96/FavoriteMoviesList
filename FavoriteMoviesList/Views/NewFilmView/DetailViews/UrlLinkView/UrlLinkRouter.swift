import UIKit

protocol UrlLinkRouterProtocol {
    func backToNewFilmView()
}

final class UrlLinkRouter: UrlLinkRouterProtocol {
    let navigationController: UINavigationController
    let completion: (String) -> Void
    
    init(navigationController: UINavigationController, completion: @escaping (String) -> Void) {
        self.navigationController = navigationController
        let view = UrlLinkViewController()
        self.completion = completion
        let presenter = UrlLinkPresenter(view: view, router: self)
        view.presenter = presenter
        presenter.textInLinkTextField = { [weak self] in
            self?.completion($0)
        }
        navigationController.pushViewController(view, animated: true)
    }
    func backToNewFilmView() {
        navigationController.popViewController(animated: true)
    }
}

