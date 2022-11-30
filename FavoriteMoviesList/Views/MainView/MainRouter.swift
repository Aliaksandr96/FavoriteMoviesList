import UIKit

protocol MainRouterProtocol {
    func openDetailView(model: FilmModel)
    func openNewFilmView()
}

final class MainRouter: MainRouterProtocol {
    let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        let view = MainViewController()
        let coreManager = CoreDataManager()
        let presenter = MainPresenter(view: view, router: self, manager: coreManager)
        view.presenter = presenter
        navigationController.pushViewController(view, animated: true)
    }
    
    func openDetailView(model: FilmModel) {
        let _ = DetailRouter(navigationController: navigationController, filmModel: model)
    }
    func openNewFilmView() {
        let _ = NewFilmRouter(navigationController: navigationController)
    }
}

