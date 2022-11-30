import UIKit
import EasyAutolayout

protocol UrlLinkViewProtocol: AnyObject {
}

final class UrlLinkViewController: UIViewController {
    // MARK: - Public
    var presenter: UrlLinkPresenterProtocol!
    
    // MARK: - Private
    private let youTubeLink = UILabel()
    private let linkTextField = UITextField()
    private let separatorView = UIView()
    private let saveButton = UIButton()

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSubviews()
        setupConstraints()
        configureUI()
        setupBehavior()
    }
    
    // MARK: - Setup Subviews
    private func setupSubviews() {
        [youTubeLink, linkTextField, separatorView, saveButton].forEach { view.addSubview($0) }
    }
    
    // MARK: - Setup Constraints
    private func setupConstraints() {
        youTubeLink.pin
            .width(to: 200).height(to: 26).centerX(in: view).top(to: view.safeAreaLayoutGuide, offset: 124)
        linkTextField.pin
            .leading(to: view, offset: 25).trailing(to: view, offset: 25).below(of: youTubeLink, offset: 40).height(to: 44)
        separatorView.pin
            .leading(to: view, offset: 25).trailing(to: view, offset: 25).height(to: 1).bottom(to: linkTextField)
        saveButton.pin
            .below(of: separatorView, offset: 40).width(to: 79).height(to: 27).centerX(in: view)
    }
    
    // MARK: - Configure UI
    private func configureUI() {
        view.backgroundColor = .white
        
        youTubeLink.font = UIFont.manropeRegularFont(withSize: 24)
        youTubeLink.text = "YouTube Link"
        youTubeLink.textAlignment = .center
        
        linkTextField.placeholder = "Write url"
        separatorView.backgroundColor = .systemGray3
        
        saveButton.setTitle("Save", for: .normal)
        saveButton.setTitleColor(.systemBlue, for: .normal)
    }
    
    // MARK: - Setup Behavior
    private func setupBehavior() {
        saveButton.addTarget(self, action: #selector(saveButtonDidTapped), for: .touchUpInside)
    }
    
    // MARK: - Helpers
    @objc private func saveButtonDidTapped() {
        presenter.backToNewFilmView()
        presenter.saveTextFromTF(text: linkTextField.text ?? "")
    }
}

// MARK: - UrlLinkProtocol
extension UrlLinkViewController: UrlLinkViewProtocol {
}
