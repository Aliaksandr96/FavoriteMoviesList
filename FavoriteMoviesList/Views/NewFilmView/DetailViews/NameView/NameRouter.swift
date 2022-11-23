import UIKit

protocol NameRouterProtocol {
    func backToNewFilmView()
}

final class NameRouter: NameRouterProtocol {
    let navigationController: UINavigationController
    let completion: (String) -> Void
    
    init(navigationController: UINavigationController, completion: @escaping ((String) -> Void)) {
        self.navigationController = navigationController
        self.completion = completion
        let view = NameViewController()
        let presenter = NamePresenter(view: view, router: self)
        view.presenter = presenter
        presenter.textInNameTextField = { [weak self] in
            self?.completion($0)
        }
        navigationController.pushViewController(view, animated: true)
    }
    func backToNewFilmView() {
        navigationController.popViewController(animated: true)
    }
}

