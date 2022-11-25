import UIKit
import EasyAutolayout

protocol ReleaseDateViewProtocol: AnyObject {
}

final class ReleaseDateViewController: UIViewController {
    // MARK: - Public
    var presenter: ReleaseDatePresenterProtocol!
    
    // MARK: - Private
    private let datePicker = UIDatePicker()
    private let releaseDateLabel = UILabel()
    private let saveButton = UIButton()

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSubviews()
        setupConstraints()
        configureUI()
        setupBehavior()
    }
    
    // MARK: - Setups
    // MARK: - Setup Subviews
    private func setupSubviews() {
        [releaseDateLabel, datePicker, saveButton].forEach { view.addSubview($0) }
    }
    // MARK: - Setup Constraints
    private func setupConstraints() {
        
        releaseDateLabel.pin
            .width(to: 200).height(to: 26).centerX(in: view).top(to: view, offset: 124)
        datePicker.pin
            .leading(to: view).trailing(to: view).below(of: releaseDateLabel, offset: 30).height(to: 131)
        saveButton.pin
            .below(of: datePicker, offset: 20).width(to: 79).height(to: 27).centerX(in: view)
    }
    // MARK: - Configure UI
    private func configureUI() {
        view.backgroundColor = .white
        
        releaseDateLabel.font = UIFont.manropeRegularFont(withSize: 24)
        releaseDateLabel.text = "Release Date"
        releaseDateLabel.textAlignment = .center

        saveButton.setTitle("Save", for: .normal)
        saveButton.setTitleColor(.systemBlue, for: .normal)
    }
    // MARK: - Setup Behavior
    private func setupBehavior() {
        saveButton.addTarget(self, action: #selector(saveButtonDidTapped), for: .touchUpInside)
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.datePickerMode = .date

    }
    @objc private func saveButtonDidTapped() {
        presenter.backToNewFilmView()
        presenter.selectedDateCallback?(datePicker.date)
    }
}

// MARK: - ReleaseDateProtocol
extension ReleaseDateViewController: ReleaseDateViewProtocol {
}

