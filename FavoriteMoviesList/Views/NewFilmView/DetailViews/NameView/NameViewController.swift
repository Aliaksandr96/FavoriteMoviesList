import UIKit
import EasyAutolayout

protocol NameViewProtocol: AnyObject {
}

final class NameViewController: UIViewController {
    // MARK: - Public
    var presenter: NamePresenterProtocol!
    
    // MARK: - Private
    private let filmNameLabel = UILabel()
    private let nameTextField = UITextField()
    private let separatorView = UIView()
    private let saveButton = UIButton()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSubviews()
        configureUI()
        setupBehavior()
        setupConstraints()
    }
    
    // MARK: - Setups
    private func setupSubviews() {
        [filmNameLabel, nameTextField, separatorView, saveButton].forEach { view.addSubview($0) }
    }
    private func setupConstraints() {
        filmNameLabel.pin
            .width(to: 200).height(to: 26).centerX(in: view).top(to: view.safeAreaLayoutGuide, offset: 124)
        nameTextField.pin
            .leading(to: view, offset: 25).trailing(to: view, offset: 25).below(of: filmNameLabel, offset: 40).height(to: 44)
        separatorView.pin
            .leading(to: view, offset: 25).trailing(to: view, offset: 25).height(to: 1).bottom(to: nameTextField)
        saveButton.pin
            .below(of: separatorView, offset: 40).width(to: 79).height(to: 27).centerX(in: view)
    }
    private func configureUI() {
        view.backgroundColor = .white
        
        filmNameLabel.font = UIFont.manropeRegularFont(withSize: 24)
        filmNameLabel.text = "Film Name"
        filmNameLabel.textAlignment = .center
        
        nameTextField.placeholder = "Name"
        separatorView.backgroundColor = .systemGray3
        
        saveButton.setTitle("Save", for: .normal)
        saveButton.setTitleColor(.systemBlue, for: .normal)
    }
    private func setupBehavior() {
        saveButton.addTarget(self, action: #selector(saveButtonDidTapped), for: .touchUpInside)
    }
    
    // MARK: - Helpers
    @objc private func saveButtonDidTapped() {
        presenter.saveTextFromTF(text: nameTextField.text ?? "")
        presenter.backToNewFilmView()
    }
}

// MARK: - NewFilmProtocol
extension NameViewController: NameViewProtocol {
    
}

