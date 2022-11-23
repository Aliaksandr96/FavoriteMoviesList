import Foundation

protocol ReleaseDatePresenterProtocol {
    func backToNewFilmView()
    var selectedDateCallback: ((Date) -> Void)? { get}
}

final class ReleaseDatePresenter {
    // MARK: - Public
    unowned var view: ReleaseDateViewProtocol
    
    // MARK: - Private
    private let router: ReleaseDateRouterProtocol
    var selectedDateCallback: ((Date) -> Void)?

    init(view: ReleaseDateViewProtocol, router: ReleaseDateRouterProtocol) {
        self.view = view
        self.router = router
    }
}

// MARK: - Extension
extension ReleaseDatePresenter: ReleaseDatePresenterProtocol {
   func backToNewFilmView() {
       router.backToNewFilmView()
    }
}
