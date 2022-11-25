import Foundation

protocol RatingPresenterProtocol {
    var pickerNumbers: [Double] { get }
    var selectedRatingCallback: ((String) -> Void)? { get }
    func backToNewFilmView()
}

final class RatingPresenter: RatingPresenterProtocol {
    // MARK: - Public
    unowned var view: RatingViewProtocol
    var selectedRatingCallback: ((String) -> Void)?
    
    
    // MARK: - Private
    private let router: RatingRouterProtocol
    var pickerNumbers = Array(stride(from: 0.1, through: 10.1, by: 0.1).reversed())

    init(view: RatingViewProtocol, router: RatingRouterProtocol) {
        self.view = view
        self.router = router
    }
    
    func backToNewFilmView() {
        router.backToNewFilmView()
    }
}

