//
//  FavoriteViewModel.swift
//  DogBreeds
//
//  Created by Bola Fayez on 02/11/2022.
//

import Foundation

protocol FavoriteViewModelProtocol {
    
    //MARK: - Protocol - Data Source
    var countOfBreedNames: Int { get }
    func breedNameAt(index: Int) -> FavoriteLayoutViewModel?
    func countOfImagesByBreedName() -> Int
    func breedImageAt(index: Int) -> String?
    func updateSelectedBreedNameBy(index: Int?)
    func getSelectedIndex() -> Int
    
    // MARK: - Protocol - load
    func loadFavoriteBreedsName(completion: @escaping FavoriteViewModel.LoadFavoriteBreedsCompletionBlock)
}

class FavoriteViewModel: FavoriteViewModelProtocol {
      
    // MARK: - Callback type alias
    typealias LoadFavoriteBreedsCompletionBlock = () -> Void
    
    // MARK: - Properties
    // Data Source
    private let dataSource: DogBreedLocalDataSourceProtocol
    private var layoutViewModels = [DogBreedLayoutViewModel.DogBreedImageLayoutViewModel]()
    private var breedNameLayoutViewModel = [FavoriteLayoutViewModel]()
    var countOfBreedNames: Int {
        return breedNameLayoutViewModel.count
    }
    var selectedIndexBreed: Int = 0

    // Init
    init(dataSource: DogBreedLocalDataSourceProtocol = DogBreedLocalDataSource()) {
        self.dataSource = dataSource
    }
    
}

// MARK: - Protocol - Data Source method
extension FavoriteViewModel {
    
    // Breed at index
    func breedNameAt(index: Int) -> FavoriteLayoutViewModel? {
        return breedNameLayoutViewModel[index]
    }
    
    // Count of images by breed name
    func countOfImagesByBreedName() -> Int {
        let breedName = getBreedNameSelectedBy(index: selectedIndexBreed)
        return getBreedImagesByName(name: breedName).count
    }
    
    // Breed image at index
    func breedImageAt(index: Int) -> String? {
        let breedName = getBreedNameSelectedBy(index: selectedIndexBreed)
        return breedImagesBy(name: breedName)?[index]
    }
    
    // Setup selected breed name
    func updateSelectedBreedNameBy(index: Int?) {
        guard let index = index else { return }
        self.selectedIndexBreed = index
    }
    
    // Breed images by name
    private func breedImagesBy(name: String) -> [String]? {
        return getBreedImagesByName(name: name)
    }
    
    // Breed images by name
    private func getBreedImagesByName(name: String) -> [String] {
        let images = layoutViewModels.map({ $0.imageURL })
        return images.filter({ $0.contains(name.lowercased()) })
    }
    
    // Get breed name selected index
    private func getBreedNameSelectedBy(index: Int) -> String {
        return breedNameLayoutViewModel[index].breedName
    }
    
    // Get selelected index
    func getSelectedIndex() -> Int {
        return selectedIndexBreed
    }
    
}

//MARK: - Protocol - Load
extension FavoriteViewModel {
    
    // loadFavoriteBreeds
    func loadFavoriteBreedsName(completion: @escaping LoadFavoriteBreedsCompletionBlock) {
        
        self.layoutViewModels = self.dataSource.loadBreeds()
        let breedNames = Array(Set(layoutViewModels.map({ $0.breedName }))).sorted()
        
        for breed in breedNames {
            self.breedNameLayoutViewModel.append( FavoriteLayoutViewModel(breedName: breed) )
        }
        
        completion()
    }
        
}
