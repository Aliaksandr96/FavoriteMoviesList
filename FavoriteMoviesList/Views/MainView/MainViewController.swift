import UIKit
import EasyAutolayout

protocol MainViewProtocol: AnyObject {
    func reloadDataTable()
}

final class MainViewController: UIViewController {
    // MARK: - Public
    var presenter: MainPresenterProtocol!

    // MARK: - Private
    private let movieListTable = UITableView()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSubviews()
        setupConstraints()
        configureUI()
        setupBehavior()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter.reloadCoreData()
    }
    
    // MARK: - Setups
    private func setupSubviews() {
        view.addSubview(movieListTable)
    }
    private func setupConstraints() {
        movieListTable.pin
            .center(in: view)
            .height(to: view)
            .width(to: view)
        movieListTable.rowHeight = 212
    }
    private func configureUI() {
        view.backgroundColor = UIColor(named: "backgroundColor")
        title = "My Movie List"
        navigationController?.navigationBar.prefersLargeTitles = true
        movieListTable.backgroundColor = .clear
        movieListTable.separatorStyle = .none
        movieListTable.layer.cornerRadius = 10
    }
    private func setupBehavior() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .plain, target: self, action: #selector(addNewFilmButtonDidTapped))
        movieListTable.dataSource = self
        movieListTable.delegate = self
        movieListTable.register(FilmsTableCustomCell.self, forCellReuseIdentifier: .identifire)
    }
    // MARK: - Helpers
    @objc private func addNewFilmButtonDidTapped() {
        presenter.openNewFilmView()
    }
}

// MARK: - MainProtocol
extension MainViewController: MainViewProtocol {
    func reloadDataTable() {
        movieListTable.reloadData()
    }
}

// MARK: - UITableViewDataSource, UITableViewDelegate
extension MainViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter.filmGetting.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: .identifire, for: indexPath) as? FilmsTableCustomCell else { return UITableViewCell() }
        cell.backgroundColor = .clear
        cell.configureCell(image: presenter.filmGetting[indexPath.row].imageFilm,
                           name: presenter.filmGetting[indexPath.row].name,
                           rating: presenter.filmGetting[indexPath.row].ratings
        )
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedCell = presenter.filmGetting[indexPath.row]
        presenter.openDetailView(model: selectedCell)
    }
}
