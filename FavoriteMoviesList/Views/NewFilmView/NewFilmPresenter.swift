import Foundation
import UIKit

protocol NewFilmPresenterProtocol {
    func saveFilmModelToCoreData(name:String, releaseDate: String,rating: String, link: String, imageFromLibrary: UIImage, descriptionText: String)
    func backToMainView()
    func openNameView()
    func openRatingView()
    func openReleaseDateView()
    func openUrlLinkView()
    func showCameraAndGalleryAlert()
}

final class NewFilmPresenter: NewFilmPresenterProtocol {
    
    // MARK: - Public
    unowned var view: NewFilmViewProtocol
    private let coreManager: CoreDataManagerProtocol
    
    // MARK: - Private
    private let router: NewFilmRouterProtocol

    init(view: NewFilmViewProtocol, router: NewFilmRouterProtocol, coreManager: CoreDataManagerProtocol) {
        self.view = view
        self.router = router
        self.coreManager = coreManager
    }
    
    func showCameraAndGalleryAlert() {
        view.showCameraAndGalleryAlert()
    }
    
    func saveFilmModelToCoreData(name:String, releaseDate: String,rating: String, link: String, imageFromLibrary: UIImage, descriptionText: String) {
        if name != "-" &&
        releaseDate != "-" &&
        rating != "-" &&
        link != "-" &&
        imageFromLibrary != UIImage(named: "backgroundImage") &&
        descriptionText != ""
        {
            let film = FilmModel(releaseDate: releaseDate,
                                 imageFilm: imageFromLibrary,
                                 name: name, ratings: rating,
                                 link: link, discription: descriptionText)
            coreManager.saveFilmModelToCoreData(film) } else {
                view.showErrorAlert()
            }
    }
    func backToMainView() {
        router.saveModelAndBackToMainView()
    }
    func openNameView() {
        router.openNameView { [weak self] text in
            self?.view.updateSelectedNameLabel(text: text)
        }
    }
    func openRatingView() {
        router.openRatingView { [weak self] text in
            self?.view.updateSelectedRatingLabel(rating: text)
        }
    }
    func openUrlLinkView() {
        router.openYouTubeLinkView { [weak self] text in 
            self?.view.updateSelectedLinkLabel(url: text)
        }
    }
    func openReleaseDateView() {
        router.openReleaseDateView { [weak self] date in
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "YYYY"
            self?.view.updateSeelectedDateLabel(date: dateFormatter.string(from: date))
        }
    }
}
