//
//  FavoriteViewController.swift
//  DogBreeds
//
//  Created by Bola Fayez on 31/10/2022.
//

import UIKit

class FavoriteViewController: UIViewController {

    // MARK: - Cell constants
    private enum Constants {
        enum Cell {
            static let breedNameReuseIdentifier = NSStringFromClass(FavoriteItemCollectionViewCell.self)
            static let breedImageReuseIdentifier = NSStringFromClass(FavoriteBreedTableViewCell.self)
        }
    }
    
    // MARK: - UI
    private let collectionView: UICollectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: FavoriteFlowLayout())
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(FavoriteBreedTableViewCell.self, forCellReuseIdentifier: Constants.Cell.breedImageReuseIdentifier)
        return tableView
    }()
    
    // MARK: - ViewModel
    private var viewModel: FavoriteViewModelProtocol
    
    // MARK: - Init
    // With viewModel
    init(viewModel: FavoriteViewModelProtocol = FavoriteViewModel()) {
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
        loadFavoriteBreeds()
    }
    
    // MARK: - setupViews
    private func setupViews() {
        
        view.backgroundColor = .white
        title = Strings.FAVORITES_TITLE
        
        // collectionView
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            collectionView.heightAnchor.constraint(equalToConstant: 56)
        ])
        collectionView.register(FavoriteItemCollectionViewCell.self, forCellWithReuseIdentifier: Constants.Cell.breedNameReuseIdentifier)
        collectionView.dataSource = self
        collectionView.showsHorizontalScrollIndicator = false
        
        // tableView
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: 16),
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

// MARK: - Load Favorite Breeds
extension FavoriteViewController {
    
    // Load Favorite Breeds
    private func loadFavoriteBreeds() {
        LoadingManager.sharedInstance.showIndicator()
        viewModel.loadFavoriteBreedsName(completion: { [weak self] in
            LoadingManager.sharedInstance.hideIndicator()
            self?.collectionView.reloadData()
            self?.tableView.reloadData()
        })
    }
    
    // Selected breed name by index
    private func isSelectedBreedNameBy(index: Int) {
        viewModel.updateSelectedBreedNameBy(index: index)
        collectionView.reloadData()
        tableView.reloadData()
    }
    
}

// MARK: - CollectionView Data source
extension FavoriteViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.countOfBreedNames
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.Cell.breedNameReuseIdentifier, for: indexPath)
        
        let layoutViewModel = viewModel.breedNameAt(index: indexPath.row)
        
        guard let layoutViewModel = layoutViewModel else {
            return cell
        }
        
        if let cell = cell as? FavoriteItemCollectionViewCell {
            cell.loadViewWithLayoutViewModel(favoriteBreed: layoutViewModel, breedIndex: indexPath.row, isSelected: viewModel.getSelectedIndex() == indexPath.row, onSelect: { [weak self] index in
                self?.isSelectedBreedNameBy(index: index)
            })
        }
        
        return cell
        
    }
    
}

// MARK: - TableView Data Source
extension FavoriteViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.countOfImagesByBreedName()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.Cell.breedImageReuseIdentifier, for: indexPath)

        let layoutViewModel = viewModel.breedImageAt(index: indexPath.row)
        
        guard let layoutViewModel = layoutViewModel else {
            return cell
        }
        
        if let cell = cell as? FavoriteBreedTableViewCell {
            cell.loadDataWithLayoutViewModel(imageURL: layoutViewModel)
        }
        
        return cell
    }
}
