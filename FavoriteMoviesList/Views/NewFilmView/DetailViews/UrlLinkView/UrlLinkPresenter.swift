import Foundation

protocol UrlLinkPresenterProtocol {
    func backToNewFilmView()
    func saveTextFromTF(text: String)
}

final class UrlLinkPresenter {
    // MARK: - Public
    unowned var view: UrlLinkViewProtocol
    var textInLinkTextField: ((String) -> Void)?
    // MARK: - Private
    private let router: UrlLinkRouterProtocol

    init(view: UrlLinkViewProtocol, router: UrlLinkRouterProtocol) {
        self.view = view
        self.router = router
    }
}

// MARK: - Extension
extension UrlLinkPresenter: UrlLinkPresenterProtocol {
    func backToNewFilmView() {
        router.backToNewFilmView()
    }
    func saveTextFromTF(text: String) {
       textInLinkTextField?(text)
    }
}
