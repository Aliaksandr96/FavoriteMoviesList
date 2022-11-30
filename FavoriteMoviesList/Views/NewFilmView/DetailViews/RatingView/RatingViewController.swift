import UIKit
import EasyAutolayout

protocol RatingViewProtocol: AnyObject {
}

final class RatingViewController: UIViewController {
    // MARK: - Public
    var presenter: RatingPresenterProtocol!
    
    // MARK: - Private
    private let ratingLabel = UILabel()
    private let ratingPicker = UIPickerView()
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
        [ratingLabel, ratingPicker, saveButton].forEach { view.addSubview($0) }
    }
    // MARK: - Setup Constraints
    private func setupConstraints() {
        ratingLabel.pin
            .width(to: 200).height(to: 30).centerX(in: view).top(to: view, offset: 124)
        ratingPicker.pin
            .leading(to: view).trailing(to: view).below(of: ratingLabel, offset: 30).height(to: 131)
        saveButton.pin
            .centerX(in: view).height(to: 27).width(to: 79).below(of: ratingPicker, offset: 20)
    }
    // MARK: - Configure UI
    private func configureUI() {
        view.backgroundColor = .white
        
        ratingLabel.font = UIFont.manropeRegularFont(withSize: 24)
        ratingLabel.text = "Your Rating"
        ratingLabel.textAlignment = .center

        saveButton.setTitle("Save", for: .normal)
        saveButton.setTitleColor(.systemBlue, for: .normal)
    }
    // MARK: - Setup Behavior
    private func setupBehavior() {
        saveButton.addTarget(self, action: #selector(saveButtonDidTapped), for: .touchUpInside)
        ratingPicker.dataSource = self
        ratingPicker.delegate = self
    }
    // MARK: - Helpers
    @objc private func saveButtonDidTapped() {
        presenter.backToNewFilmView()
    }
}

// MARK: - Extensions View
extension RatingViewController: RatingViewProtocol {
}

extension RatingViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        presenter.pickerNumbers.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        String(format: "%.1f", presenter.pickerNumbers[row])
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        presenter.selectedRatingCallback?(String(format: "%.1f", presenter.pickerNumbers[row]))
    }
}
