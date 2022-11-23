import UIKit

protocol ReleaseDateRouterProtocol {
    func backToNewFilmView() 
}

final class ReleaseDateRouter: ReleaseDateRouterProtocol {
    let navigationController: UINavigationController
    let completion: (Date) -> Void
    
    init(navigationController: UINavigationController, completion: @escaping((Date) -> Void)) {
        self.navigationController = navigationController
        self.completion = completion
        let view = ReleaseDateViewController()
        let presenter = ReleaseDatePresenter(view: view, router: self)
        view.presenter = presenter
        presenter.selectedDateCallback = { [weak self] in
            self?.completion($0)
        }
        navigationController.pushViewController(view, animated: true)
    }
    func backToNewFilmView() {
        navigationController.popViewController(animated: true)
    }
}

