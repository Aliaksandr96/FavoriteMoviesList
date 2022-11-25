import UIKit
import EasyAutolayout

protocol NewFilmViewProtocol: AnyObject {
    func updateSelectedNameLabel(text: String)
    func updateSelectedLinkLabel(url: String)
    func updateSelectedRatingLabel(rating: String)
    func updateSeelectedDateLabel(date: String)
    func showErrorAlert()
    func showCameraAndGalleryAlert()
}

final class NewFilmViewController: UIViewController {
    // MARK: - Public
    var presenter: NewFilmPresenterProtocol!
    
    // MARK: - Private
    private let movieImageView = UIImageView()
    private let addImageButton = UIButton()
    private let nameLabel = UILabel()
    private let selectedNameLabel = UILabel()
    private let selectNameButton = UIButton()
    private let ratingLabel = UILabel()
    private let selectedRatingLabel = UILabel()
    private let selectRatingButton = UIButton()
    private let releaseDateLabel = UILabel()
    private let selectedDateLabel = UILabel()
    private let selectReleaseDateButton = UIButton()
    private let youTubeLinkLabel = UILabel()
    private let selectedLinkLabel = UILabel()
    private let selectYouTubeLinkButton = UIButton()
    private let descriptionlabel = UILabel()
    private let descriptionTextView = UITextView()
    private let pickerImage = UIImagePickerController()
    private var imageFromLibrary: UIImage?
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSubviews()
        setupConstraints()
        configureUI()
        setupBehavior()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWiilShow(notification: )), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    override func viewWillDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self)
    }
    
    // MARK: - Setup Subviews
    private func setupSubviews() {
        [movieImageView, addImageButton, nameLabel,selectedNameLabel, ratingLabel, selectedRatingLabel,releaseDateLabel,selectedDateLabel, youTubeLinkLabel,selectedLinkLabel ,selectNameButton, selectRatingButton, selectReleaseDateButton, selectYouTubeLinkButton, descriptionlabel, descriptionTextView].forEach { view.addSubview($0)}
    }
    // MARK: - Setup Constraints
    private func setupConstraints() {
        movieImageView.pin
            .top(to: view.safeAreaLayoutGuide, offset: 30).centerX(in: view).width(to: 150).height(to: 150)
        addImageButton.pin
            .center(in: movieImageView).width(to: 70).height(to: 70)
        nameLabel.pin
            .leading(to: view, offset: 40).below(of: movieImageView, offset: 32)
            .width(to: 125).height(to: 25)
        selectedNameLabel.pin
            .below(of: nameLabel).width(to: nameLabel).height(to: nameLabel).centerX(in: nameLabel)
        selectNameButton.pin
            .below(of: selectedNameLabel).width(to: nameLabel).height(to: nameLabel).centerX(in: nameLabel)
        releaseDateLabel.pin
            .below(of: selectNameButton, offset: 32).width(to: 125).height(to: 25).leading(to: view, offset: 40)
        selectedDateLabel.pin
            .below(of: releaseDateLabel).width(to: 125).height(to: 25).centerX(in: releaseDateLabel)
        selectReleaseDateButton.pin
            .below(of: selectedDateLabel).width(to: 125).height(to: 25).centerX(in: releaseDateLabel)
        ratingLabel.pin
            .trailing(to: view, offset: 40).below(of: movieImageView, offset: 32)
            .width(to: 125).height(to: 25)
        selectedRatingLabel.pin
            .below(of: ratingLabel).width(to: ratingLabel).height(to: ratingLabel).centerX(in: ratingLabel)
        selectRatingButton.pin
            .below(of: selectedRatingLabel).width(to: ratingLabel).height(to: ratingLabel).centerX(in: ratingLabel)
        youTubeLinkLabel.pin
            .below(of: selectRatingButton, offset: 32).width(to: 125).height(to: 25).trailing(to: view, offset: 40)
        selectedLinkLabel.pin
            .below(of: youTubeLinkLabel).width(to: 125).height(to: 25).centerX(in: youTubeLinkLabel)
        selectYouTubeLinkButton.pin
            .below(of: selectedLinkLabel).width(to: 125).height(to: 25).centerX(in: selectedLinkLabel)
        descriptionlabel.pin
            .below(of: selectYouTubeLinkButton, offset: 36)
            .width(to: 311).height(to: 26)
            .centerX(in: view)
        descriptionTextView.pin
            .below(of: descriptionlabel, offset: 11)
            .leading(to: view, offset: 32).trailing(to: view, offset: 32)
            .bottom(to: view.safeAreaLayoutGuide)
    }
    // MARK: - Configure UI
    private func configureUI() {
        view.backgroundColor = .white
        title = "Add New"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        movieImageView.layer.cornerRadius = 75
        movieImageView.clipsToBounds = true
        movieImageView.image = UIImage(named: "backgroundImage")
        movieImageView.contentMode = .scaleAspectFill
        addImageButton.setImage(UIImage(named: "addImage"), for: .normal)
        
        [selectNameButton, selectRatingButton, selectReleaseDateButton, selectYouTubeLinkButton].forEach { $0.setTitle("Change", for: .normal)}
        [selectNameButton, selectRatingButton, selectReleaseDateButton, selectYouTubeLinkButton].forEach { $0.setTitleColor(.systemBlue, for: .normal)}
       
        [nameLabel, selectedNameLabel, ratingLabel, selectedRatingLabel, releaseDateLabel, selectedDateLabel, youTubeLinkLabel,selectedLinkLabel].forEach { $0.textAlignment = .center }
        [nameLabel, selectedNameLabel, ratingLabel, selectedRatingLabel, releaseDateLabel, selectedDateLabel, youTubeLinkLabel,selectedLinkLabel].forEach { $0.font = UIFont.manropeRegularFont(withSize: 18)}
        [selectedNameLabel, selectedRatingLabel, selectedDateLabel, selectedLinkLabel].forEach { $0.text = "-" }
   
        nameLabel.text = "Name"
        ratingLabel.text = "Your Rating"
        releaseDateLabel.text = "Release Date"
        youTubeLinkLabel.text = "YouTubeLink"
        
        descriptionlabel.text = "Description"
        descriptionlabel.textAlignment = .center
        descriptionlabel.font = UIFont.manropeRegularFont(withSize: 18)
        descriptionTextView.backgroundColor = .systemGray6
        descriptionTextView.text = ""
    }
    // MARK: - Setup Behavior
    private func setupBehavior() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(saveButtonDidTapped))
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(hideKeyboard)))
        addImageButton.addTarget(self, action: #selector(addImageButtonDidTapped), for: .touchUpInside)
        selectNameButton.addTarget(self, action: #selector(selectNameButtonDidTapped), for: .touchUpInside)
        selectRatingButton.addTarget(self, action: #selector(selectRatingButtonDidTapped), for: .touchUpInside)
        selectReleaseDateButton.addTarget(self, action: #selector(selectReleaseDateButtonDidTapped), for: .touchUpInside)
        selectYouTubeLinkButton.addTarget(self, action: #selector(selectYouTubeLinkButtonDidTapped), for: .touchUpInside)
        
        pickerImage.delegate = self
    }
    // MARK: - Helpers
    @objc private func saveButtonDidTapped() {
            presenter.saveFilmModelToCoreData(name: selectedNameLabel.text ?? "",
                                              releaseDate: selectedDateLabel.text ?? "",
                                              rating: selectedRatingLabel.text ?? "",
                                              link: selectedLinkLabel.text ?? "",
                                              imageFromLibrary: movieImageView.image ?? UIImage(),
                                              descriptionText: descriptionTextView.text ?? "")
            presenter.backToMainView()
    }
    @objc private func addImageButtonDidTapped() {
        presenter.showCameraAndGalleryAlert()
    }
    @objc private func selectNameButtonDidTapped() {
        presenter.openNameView()
    }
    @objc private func selectRatingButtonDidTapped() {
        presenter.openRatingView()
    }
    @objc private func selectReleaseDateButtonDidTapped() {
        presenter.openReleaseDateView()
    }
    @objc private func selectYouTubeLinkButtonDidTapped() {
        presenter.openUrlLinkView()
    }
    @objc private func hideKeyboard(){
        view.endEditing(true)
    }
    @objc private func keyboardWiilShow(notification: NSNotification) {
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardTopY = keyboardFrame.cgRectValue.origin.y
            let convertFrame = view.convert(descriptionTextView.frame, from: descriptionTextView.superview)
            let BottomY = convertFrame.origin.y + convertFrame.size.height
            if BottomY > keyboardTopY {
                let textY = convertFrame.origin.y
                let newFrameY = (textY - keyboardTopY / 2) * -1
                title = nil
                view.frame.origin.y = newFrameY
            }
        }
    }
    @objc private func keyboardWillHide() {
        view.frame.origin.y = 0
        title = "Add New"
    }
}

// MARK: - NewFilmProtocol
extension NewFilmViewController: NewFilmViewProtocol {
    func updateSelectedNameLabel(text: String) {
        selectedNameLabel.text = text
    }
    func updateSelectedLinkLabel(url: String) {
        selectedLinkLabel.text = url
    }
    func updateSelectedRatingLabel(rating: String) {
        selectedRatingLabel.text = rating
    }
    func updateSeelectedDateLabel(date: String) {
        selectedDateLabel.text = date
    }
    
    func showErrorAlert() {
        let alertController = UIAlertController(title: "Error", message: "Please fill in all the information", preferredStyle: .alert)
        let okayAction = UIAlertAction(title: "Cancel", style: .destructive)
        alertController.addAction(okayAction)
       self.present(alertController, animated: true, completion: nil)
     }
    func showCameraAndGalleryAlert() {
        let alertController = UIAlertController(title: "Choose Image", message: "", preferredStyle: .actionSheet)
        let cameraAction = UIAlertAction(title: "Camera", style: .default, handler: { [unowned self] _ in
            pickerImage.sourceType = UIImagePickerController.SourceType.camera
            pickerImage.allowsEditing = true
            self.present(pickerImage, animated: true)
        })
        let galleryAction = UIAlertAction(title: "Gallery", style: .default, handler: { [unowned self] _ in
            pickerImage.sourceType = UIImagePickerController.SourceType.photoLibrary
            pickerImage.allowsEditing = true
            self.present(pickerImage, animated: true)
        })
        let cancell = UIAlertAction(title: "Cancel", style: .cancel)
        alertController.addAction(cancell)
        alertController.addAction(cameraAction)
        alertController.addAction(galleryAction)
        present(alertController, animated: true)
    }
}

// MARK: - UIImagePickerControllerDelegate, UINavigationControllerDelegate
extension NewFilmViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.editedImage] as? UIImage {
            imageFromLibrary = image
            movieImageView.image = imageFromLibrary
            addImageButton.layer.opacity = 0.15
        }
        picker.dismiss(animated: true)
    }
}

