//
//  DogBreedViewModel.swift
//  DogBreeds
//
//  Created by Bola Fayez on 31/10/2022.
//

import Foundation

protocol DogBreedViewModelProtocol {
    
    //MARK: - Protocol - Data Source
    var countOfBreeds: Int { get }
    var breedName: String { get }
    func breedAt(index: Int) -> String
    func breedImagesBy(name: String) -> [DogBreedLayoutViewModel.DogBreedImageLayoutViewModel]?
    func addOrRemoveFromFav(imageURL: String, isFav: Bool)

    // MARK: - Protocol - fetch
    func fetchDogBreedImages(completion: @escaping DogBreedViewModel.GetDogBreedImagesCompletionBlock)
}

class DogBreedViewModel: DogBreedViewModelProtocol {

    // MARK: - Callback type alias
    typealias GetDogBreedImagesCompletionBlock = (Result<Bool, ErrorManager>) -> Void

    // MARK: - Properties
    // Data Source
    private let dogBreedRepository: DogBreedRepositoryProtocol
    private var layoutViewModel: DogBreedLayoutViewModel?
    private var imagesLayoutViewModel = [DogBreedLayoutViewModel.DogBreedImageLayoutViewModel]()
    private var breed: String
    private var breeds: [String]
    var breedName: String {
        return self.breed.capitalized
    }
    var countOfBreeds: Int {
        return breeds.isEmpty ? 1 : breeds.count
    }
    
    // Init
    init(breed: String = "", breeds: [String] = [], dogBreedRepository: DogBreedRepositoryProtocol = DogBreedRepository()) {
        
        self.breed = breed
        self.breeds = breeds
        self.dogBreedRepository = dogBreedRepository
    }
    
}

// MARK: - Protocol - Data Source method
extension DogBreedViewModel {
    
    // Breed at index
    func breedAt(index: Int) -> String {
        return breeds.isEmpty ? "" : self.breeds[index].capitalized
    }
    
    // Breed images by name
    func breedImagesBy(name: String) -> [DogBreedLayoutViewModel.DogBreedImageLayoutViewModel]? {
        let breedName = breeds.isEmpty ? breedName : name
        let images = self.imagesLayoutViewModel.filter({ $0.imageURL.contains(breedName.lowercased()) })
        return images
    }
    
    // AddOrRemoveFromFav
    func addOrRemoveFromFav(imageURL: String, isFav: Bool) {
        guard let index = self.imagesLayoutViewModel.firstIndex(where: { $0.imageURL.contains(imageURL) }),
        var breed = self.imagesLayoutViewModel.first(where: { $0.imageURL.contains(imageURL) }) else { return }
        
        breed.updateFav(isFav: isFav)
        self.imagesLayoutViewModel[index] = breed
        
        if isFav {
            dogBreedRepository.addFav(breedName: breedName, breed: breed)
        } else {
            dogBreedRepository.removeFav(breedName: breedName, breed: breed)
        }
    }
    
    // UpdateTheBreedWithFav
    private func updateTheBreedWithFav() {
        let localLayoutViewModel = self.dogBreedRepository.getAllFavBreed()
        for local in localLayoutViewModel {
            if let index = self.imagesLayoutViewModel.firstIndex(where: { $0.imageURL.contains(local.imageURL) }),
               var breed = self.imagesLayoutViewModel.first(where: { $0.imageURL.contains(local.imageURL) }) {
                breed.updateFav(isFav: true)
                self.imagesLayoutViewModel[index] = breed
            }
        }
    }
    
}

// MARK: - Protocol - fetch
extension DogBreedViewModel {
    
    func fetchDogBreedImages(completion: @escaping GetDogBreedImagesCompletionBlock) {
        dogBreedRepository.fetchDogBreedImages(breedName: breed, completion: { [weak self] (result: Result<DogBreedLayoutViewModel, ErrorManager>) in
            switch result {
            case .success(let layoutViewModel):
                self?.layoutViewModel = layoutViewModel
                guard let breedImages = self?.layoutViewModel?.getTheBreedImagesWithFav() else { return completion(.success(true)) }
                self?.imagesLayoutViewModel = breedImages
                self?.updateTheBreedWithFav()
                completion(.success(true))
            case .failure(let error):
                completion(.failure(.parser(string: error.localizedDescription)))
            }
        })
        
    }
    
}
