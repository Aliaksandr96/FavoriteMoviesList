import UIKit

protocol NewFilmRouterProtocol {
    func openNameView(completion: @escaping((String) -> Void))
    func openYouTubeLinkView(completion: @escaping((String) -> Void))
    func openRatingView(completion: @escaping((String) -> Void))
    func openReleaseDateView(completion: @escaping((Date) -> Void))
    func saveModelAndBackToMainView()
}

final class NewFilmRouter: NewFilmRouterProtocol {
    let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        print("New Film View init")
        self.navigationController = navigationController
        let view = NewFilmViewController()
        let manager = CoreDataManager()
        let presenter = NewFilmPresenter(view: view, router: self, coreManager: manager)
        view.presenter = presenter
        navigationController.pushViewController(view, animated: true)
    }
    
    func openNameView(completion: @escaping((String) -> Void)) {
        let _ = NameRouter(navigationController: navigationController, completion: completion)
    }
    func openYouTubeLinkView(completion: @escaping ((String) -> Void)) {
        let _ = UrlLinkRouter(navigationController: navigationController, completion: completion)
    }
    func openRatingView(completion: @escaping ((String) -> Void)) {
        let _ = RatingRouter(navigationController: navigationController, completion: completion)
    }
    func openReleaseDateView(completion: @escaping ((Date) -> Void)) {
        let _ = ReleaseDateRouter(navigationController: navigationController, completion: completion)
    }
    func saveModelAndBackToMainView() {
        navigationController.popViewController(animated: true)
    }
}

