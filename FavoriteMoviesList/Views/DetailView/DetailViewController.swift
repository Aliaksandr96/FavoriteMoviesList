import UIKit
import WebKit
import EasyAutolayout

protocol DetailViewProtocol: AnyObject {
    func updateLabels(filmImage: UIImage, nameFilm: String, rating: String, releaseDate: String, textViewText: String, link: String)
}

final class DetailViewController: UIViewController {
    // MARK: - Public
    var presenter: DetailPresenterProtocol!

    // MARK: - Private
    private let filmImageView = UIImageView()
    private let informationView = UIView()
    private let nameFilmLabel = UILabel()
    private let ratingFilmLabel = UILabel()
    private let numberTenLabel = UILabel()
    private let releaseFilmLabel = UILabel()
    private let descriptionTextView = UITextView()
    private let trailerView = WKWebView()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSubviews()
        setupConstraints()
        configureUI()
    }
    
    // MARK: - Setups
    // MARK: - Setup Subviews
    private func setupSubviews() {
        [filmImageView, informationView, nameFilmLabel, ratingFilmLabel,numberTenLabel , releaseFilmLabel,descriptionTextView, trailerView].forEach { view.addSubview($0) }
    }
    // MARK: - Setup Constraints
    private func setupConstraints() {
        filmImageView.pin
            .top(to: view).leading(to: view).trailing(to: view).height(to: 286)
        informationView.pin
            .below(of: filmImageView, offset: -15).width(to: filmImageView).bottom(to: view)
        nameFilmLabel.pin
            .top(to: informationView, offset: 15).leading(to: informationView, offset: 15).trailing(to: informationView, offset: 15).height(to: 70)
        ratingFilmLabel.pin
            .below(of: nameFilmLabel).width(to: 55).leading(to: nameFilmLabel).height(to: 25)
        numberTenLabel.pin
            .centerY(in: ratingFilmLabel).width(to: 30).after(of: ratingFilmLabel).height(to: 25)
        releaseFilmLabel.pin
            .top(to: ratingFilmLabel).height(to: 25).width(to: 100).after(of: numberTenLabel, offset: 5)
        descriptionTextView.pin
            .below(of: releaseFilmLabel, offset: 10).leading(to: view, offset: 15).trailing(to: view, offset: 15).height(to: 150)
        trailerView.pin
            .bottom(to: view.safeAreaLayoutGuide, offset: 10).leading(to: view, offset: 15).trailing(to: view, offset: 15).below(of: descriptionTextView, offset: 10)
    }
    // MARK: - Configure UI
    private func configureUI() {
        [numberTenLabel, releaseFilmLabel].forEach { $0.font = UIFont.manropeRegularFont(withSize: 14) }
        [numberTenLabel, releaseFilmLabel].forEach { $0.textColor = UIColor(named: "customGray") }
        view.backgroundColor = .white
        
        informationView.backgroundColor = .white
        informationView.layer.cornerRadius = 10
        informationView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
        nameFilmLabel.font = UIFont.manropeBoldFont(withSize: 24)
        nameFilmLabel.numberOfLines = 2

        ratingFilmLabel.font = UIFont.manropeBoldFont(withSize: 14)
        numberTenLabel.text = "/ 10"
        descriptionTextView.isEditable = false
        descriptionTextView.font = UIFont.manropeRegularFont(withSize: 14)
    }
}

// MARK: - DetailProtocol
extension DetailViewController: DetailViewProtocol {
    func updateLabels(filmImage: UIImage, nameFilm: String, rating: String, releaseDate: String, textViewText: String, link: String) {
        filmImageView.image = filmImage
        nameFilmLabel.text = nameFilm
        ratingFilmLabel.text = "⭐️ \(rating)"
        releaseFilmLabel.text = releaseDate
        descriptionTextView.text = textViewText
        trailerView.load(URLRequest(url:URL(string: link)!))
    }
}
