//
//  DogBreedViewController.swift
//  DogBreeds
//
//  Created by Bola Fayez on 31/10/2022.
//

import UIKit

class DogBreedViewController: UIViewController {
    
    // MARK: - Cell constants
    private enum Constants {
        enum Cell {
            static let reuseIdentifier = NSStringFromClass(DogBreedTableViewCell.self)
        }
    }
    
    // MARK: - ViewModel
    private let viewModel: DogBreedViewModelProtocol

    // MARK: - UI
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(DogBreedTableViewCell.self, forCellReuseIdentifier: Constants.Cell.reuseIdentifier)
        return tableView
    }()
    
    // MARK: - Init
    // With viewModel
    init(viewModel: DogBreedViewModelProtocol = DogBreedViewModel()) {
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
        fetchDogBreedImages()
    }
    
    // MARK: - setupViews
    private func setupViews() {
        
        view.backgroundColor = .white
        title = viewModel.breedName
        
        // tableView
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
        tableView.separatorStyle = .none
        tableView.dataSource = self
        tableView.estimatedRowHeight = 150
        tableView.rowHeight = UITableView.automaticDimension
    }
    
}

// MARK: - Fetch Dog Breeds
extension DogBreedViewController {
    
    private func fetchDogBreedImages() {
        LoadingManager.sharedInstance.showIndicator()
        viewModel.fetchDogBreedImages(completion: { [weak self] result in
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

// MARK: - DogBreed action
extension DogBreedViewController {
    
    // MARK: - handleAction
    private func handleAction(_ action: DogBreedAction) {
        switch action {
        case .addOrRemoveFromFav(imageURL: let imageURL, isFav: let isFav):
            addOrRemoveFromFav(imageURL: imageURL, isFav: isFav)
        }
    }
    
    // AddOrRemoveFav
    private func addOrRemoveFromFav(imageURL: String, isFav: Bool) {
        viewModel.addOrRemoveFromFav(imageURL: imageURL, isFav: isFav)
//        UIView.performWithoutAnimation {
//            DispatchQueue.main.async { [weak self] in
//                self?.tableView.reloadData()
//            }
//        }
    }
    
}

// MARK: - TableView Data Source
extension DogBreedViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.countOfBreeds
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return viewModel.breedAt(index: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.Cell.reuseIdentifier, for: indexPath)
        
        let layoutViewModel = viewModel.breedImagesBy(name: viewModel.breedAt(index: indexPath.section))
        
        guard let layoutViewModel = layoutViewModel else {
            return cell
        }
        
        if let cell = cell as? DogBreedTableViewCell {
            cell.loadViewWithLayoutViewModel(breedImages: layoutViewModel, onAction: self.handleAction(_:))
        }
        
        return cell
    }
}
