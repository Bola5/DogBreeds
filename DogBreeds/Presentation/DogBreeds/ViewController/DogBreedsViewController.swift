//
//  DogBreedsViewController.swift
//  DogBreeds
//
//  Created by Bola Fayez on 25/10/2022.
//

import UIKit

class DogBreedsViewController: UIViewController {

    // MARK: - Cell constants
    private enum Constants {
        enum Cell {
            static let reuseIdentifier = NSStringFromClass(DogBreedsTableViewCell.self)
        }
    }
    
    // MARK: - UI
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(DogBreedsTableViewCell.self, forCellReuseIdentifier: Constants.Cell.reuseIdentifier)
        return tableView
    }()
    
    // Scroll to top button
    private let scrollToTopButton = UIButton()
    
    // MARK: - ViewModel
    private let viewModel: DogBreedsViewModelProtocol
    
    // MARK: - Init
    // With viewModel
    init(viewModel: DogBreedsViewModelProtocol = DogBreedsViewModel()) {
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
    
        setupViews()
        fetchDogBreeds()
    }
    
    // MARK: - setupViews
    private func setupViews() {
        
        view.backgroundColor = .white
        title = Strings.DOG_BREEDS_TITLE
        
        // tableView
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
        tableView.separatorStyle = .singleLine
        tableView.dataSource = self
        tableView.delegate = self

        // Scroll to top
        // Button
        scrollToTopButton.layer.cornerRadius = 28
        scrollToTopButton.layer.shadowColor = UIColor.black.cgColor
        scrollToTopButton.layer.shadowOpacity = 0.12
        scrollToTopButton.layer.shadowRadius = 3.0
        scrollToTopButton.layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
        scrollToTopButton.isHidden = true
        scrollToTopButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollToTopButton)
        NSLayoutConstraint.activate([
            scrollToTopButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            scrollToTopButton.bottomAnchor.constraint(equalTo: tableView.bottomAnchor, constant: -16),
            scrollToTopButton.heightAnchor.constraint(equalToConstant: 56),
            scrollToTopButton.widthAnchor.constraint(equalToConstant: 56)
        ])
        scrollToTopButton.addTarget(self, action: #selector(scrollToTopAction), for: .touchUpInside)

        // Image
        let arrowImageView = UIImageView.init(image: UIImage(named: Strings.SCROLL_TO_TOP_IMAGE_NAME))
        arrowImageView.translatesAutoresizingMaskIntoConstraints = false
        scrollToTopButton.addSubview(arrowImageView)
        NSLayoutConstraint.activate([
            arrowImageView.centerXAnchor.constraint(equalTo: scrollToTopButton.centerXAnchor),
            arrowImageView.centerYAnchor.constraint(equalTo: scrollToTopButton.centerYAnchor)
        ])
        
        // Fav
        addFavButton()
    }
    
    // MARK: - scrollToTopAction
    @objc func scrollToTopAction(sender: UIButton!) {
        self.tableView.setContentOffset(.zero, animated: true)
    }

}

// MARK: - Fav
extension DogBreedsViewController {
    
    // MARK: - addFavButton
    private func addFavButton() {
        let img = UIImage(named: Strings.FAV_IMAGE_NAME)!.withRenderingMode(.alwaysOriginal)
        let rightButton = UIBarButtonItem(image: img, style: UIBarButtonItem.Style.plain, target: self, action: #selector(self.moveToFaveScreen))
        self.navigationItem.rightBarButtonItem = rightButton
    }
    
    // MARK: - moveToFavScreen
    @objc func moveToFaveScreen() {
        let favoriteViewController = FavoriteViewController()
        self.navigationController?.pushViewController(favoriteViewController, animated: true)
    }
    
}

// MARK: - Fetch Dog Breeds
extension DogBreedsViewController {
    
    private func fetchDogBreeds() {
        LoadingManager.sharedInstance.showIndicator()
        viewModel.fetchDogBreedsList(completion: { [weak self] result in
            LoadingManager.sharedInstance.hideIndicator()
            switch result {
            case .success:
                self?.handleFetchSuccess()
            case .failure(let error):
                self?.handleFailure(error: error.getStringError() ?? "")
            }
        })
    }
    
    private func handleFetchSuccess() {
        DispatchQueue.main.async { [weak self] in
            self?.tableView.reloadData()
        }
    }
    
    private func handleFailure(error: String) {
        DispatchQueue.main.async { [weak self] in
            self?.showErrorAlert(message: error)
        }
    }
    
}

// MARK: - Scroll to top
extension DogBreedsViewController {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if (scrollView.contentOffset.y >= scrollView.frame.size.height) {
            scrollToTopButton.isHidden = false
        } else {
            scrollToTopButton.isHidden = true
        }
    }
}

// MARK: - TableView Data Source
extension DogBreedsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.countOfBreeds
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.Cell.reuseIdentifier, for: indexPath)

        let layoutViewModel = viewModel.breedAt(index: indexPath.row)
        
        guard let layoutViewModel = layoutViewModel else {
            return cell
        }
        
        if let cell = cell as? DogBreedsTableViewCell {
            cell.loadViewWithLayoutViewModel(breedName: layoutViewModel)
        }
        
        return cell
    }
}

// MARK: - TableView Delegate
extension DogBreedsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let breedName = viewModel.breedAt(index: indexPath.row)?.lowercased() else {
            return
        }
        
        let viewController = DogBreedViewController(viewModel: DogBreedViewModel(breed: breedName, breeds: viewModel.breedsBy(name: breedName)))
        navigationController?.pushViewController(viewController, animated: true)
    }
    
}
