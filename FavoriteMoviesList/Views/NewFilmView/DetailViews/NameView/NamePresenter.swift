import Foundation

protocol NamePresenterProtocol {
    func backToNewFilmView()
    func saveTextFromTF(text: String)
}

final class NamePresenter {
    // MARK: - Public
    unowned var view: NameViewProtocol
    var textInNameTextField: ((String) -> Void)?
    
    // MARK: - Private
    private let router: NameRouterProtocol

    init(view: NameViewProtocol, router: NameRouterProtocol) {
        self.view = view
        self.router = router
    }
}

// MARK: - Extension
extension NamePresenter: NamePresenterProtocol {
    func backToNewFilmView(){
        router.backToNewFilmView()
    }
    func saveTextFromTF(text: String) {
        textInNameTextField?(text)
    }
}
