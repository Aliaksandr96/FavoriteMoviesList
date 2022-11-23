import UIKit

final class FilmsTableCustomCell: UITableViewCell {
    // MARK: Private
    private let filmImage = UIImageView()
    private let filmNameLabel = UILabel()
    private let ratingLabel = UILabel()
    private let numberTenLabel = UILabel()
    private let infoView = UIView()
    
    // MARK: - Lifecycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: .identifire)
        setupSubviews()
        setupConstraints()
        configureUI()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setups
    // MARK: - Setups
    private func setupSubviews() {
        contentView.addSubview(infoView)
        [filmImage, filmNameLabel, ratingLabel, numberTenLabel].forEach{ infoView.addSubview($0) }
    }
    private func setupConstraints() {
        [infoView, filmImage, filmNameLabel, ratingLabel, numberTenLabel].forEach{ $0.translatesAutoresizingMaskIntoConstraints = false }
        NSLayoutConstraint.activate([
            infoView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            infoView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            infoView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            infoView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            
            filmImage.leadingAnchor.constraint(equalTo: infoView.leadingAnchor),
            filmImage.widthAnchor.constraint(equalToConstant: 195),
            filmImage.heightAnchor.constraint(equalTo: infoView.heightAnchor),

            filmNameLabel.leadingAnchor.constraint(equalTo: filmImage.trailingAnchor, constant: 15),
            filmNameLabel.trailingAnchor.constraint(equalTo: infoView.trailingAnchor, constant: -15),
            filmNameLabel.topAnchor.constraint(equalTo: infoView.topAnchor, constant: 34),
            filmNameLabel.heightAnchor.constraint(equalTo: infoView.heightAnchor, multiplier: 1/2),
            
            ratingLabel.topAnchor.constraint(equalTo: filmNameLabel.bottomAnchor, constant: 10),
            ratingLabel.centerXAnchor.constraint(equalTo: filmNameLabel.centerXAnchor, constant:  -15),
            ratingLabel.widthAnchor.constraint(equalToConstant: 35),
            ratingLabel.heightAnchor.constraint(equalToConstant: 30),
            
            numberTenLabel.centerYAnchor.constraint(equalTo: ratingLabel.centerYAnchor),
            numberTenLabel.leadingAnchor.constraint(equalTo: ratingLabel.trailingAnchor),
            numberTenLabel.widthAnchor.constraint(equalToConstant: 30),
            numberTenLabel.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
    private func configureUI() {
        [filmNameLabel, ratingLabel].forEach{ $0.textAlignment = .center }
        [filmNameLabel, ratingLabel ].forEach {$0.font = UIFont.manropeRegularFont(withSize: 18) }
        [filmImage, infoView].forEach { $0.layer.cornerRadius = 10 }
        filmNameLabel.numberOfLines = 4
        ratingLabel.font = UIFont.manropeBoldFont(withSize: 16)
        numberTenLabel.text = "/ 10"
        
        filmImage.clipsToBounds = true
        filmImage.layer.maskedCorners = [.layerMinXMinYCorner, .layerMinXMaxYCorner]
        
        infoView.backgroundColor = .white
        infoView.layer.shadowColor = UIColor.systemGray4.cgColor
        infoView.layer.shadowOpacity = 1
        infoView.layer.shadowRadius = 10
    }
    func configureCell(image: UIImage?, name: String, rating: String) {
        filmImage.image = image
        filmNameLabel.text = name
        ratingLabel.text = rating
    }
}
