import UIKit

protocol RatingRouterProtocol {
    func backToNewFilmView()
}

final class RatingRouter: RatingRouterProtocol {
    let navigationController: UINavigationController
    let completion: (String) -> Void
    
    init(navigationController: UINavigationController, completion: @escaping ((String) -> Void)) {
        self.navigationController = navigationController
        self.completion = completion
        let view = RatingViewController()
        let presenter = RatingPresenter(view: view, router: self)
        view.presenter = presenter
        presenter.selectedRatingCallback = { [weak self] in
            self?.completion($0)
        }
        navigationController.pushViewController(view, animated: true)
    }
    func backToNewFilmView() {
        navigationController.popViewController(animated: true)
    }
}

