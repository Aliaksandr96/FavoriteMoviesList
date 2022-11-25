import Foundation
import UIKit

protocol DetailPresenterProtocol {
    func getModelFromMainView()
}

final class DetailPresenter: DetailPresenterProtocol {
    // MARK: - Public
    unowned var view: DetailViewProtocol
    
    
    // MARK: - Private
    private let router: DetailRouterProtocol
    private let filmModel: FilmModel
    
    init(view: DetailViewProtocol, router: DetailRouterProtocol, filmModel: FilmModel) {
        self.view = view
        self.router = router
        self.filmModel = filmModel
        getModelFromMainView()
    }

    func getModelFromMainView() {
        view.updateLabels(filmImage: filmModel.imageFilm,
                                             nameFilm: filmModel.name,
                                             rating: filmModel.ratings,
                                             releaseDate: filmModel.releaseDate,
                                             textViewText: filmModel.discription,
                                             link: filmModel.link)
    }
}
