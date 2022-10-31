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
    func breedImagesBy(name: String) -> [String]?

    // MARK: - Protocol - fetch
    func fetchDogBreedImages(completion: @escaping DogBreedViewModel.GetDogBreedImagesCompletionBlock)
}

class DogBreedViewModel: DogBreedViewModelProtocol {

    // MARK: - Callback type alias
    typealias GetDogBreedImagesCompletionBlock = (Result<Bool, ErrorManager>) -> Void

    // MARK: - Properties
    // Data Source
    private let dogBreedDataSource: DogBreedDataSourceProtocol
    private var layoutViewModel = [String]()
    private var breed: String
    private var breeds: [String]
    var breedName: String {
        return self.breed.capitalized
    }
    var countOfBreeds: Int {
        return breeds.isEmpty ? 1 : breeds.count
    }
    
    // Init
    init(breed: String = "", breeds: [String] = [], dogBreedDataSource: DogBreedDataSourceProtocol = DogBreedDataSource()) {
        
        self.breed = breed
        self.breeds = breeds
        self.dogBreedDataSource = dogBreedDataSource
    }
    
}

// MARK: - Protocol - Data Source method
extension DogBreedViewModel {
    
    // Breed at index
    func breedAt(index: Int) -> String {
        return breeds.isEmpty ? "" : self.breeds[index].capitalized
    }
    
    // Breed images by name
    func breedImagesBy(name: String) -> [String]? {
        let breedName = breeds.isEmpty ? breedName : name
        let images = self.layoutViewModel.filter({ $0.contains(breedName.lowercased()) })
        return images
    }
    
}

// MARK: - Protocol - fetch
extension DogBreedViewModel {
    
    func fetchDogBreedImages(completion: @escaping GetDogBreedImagesCompletionBlock) {
        dogBreedDataSource.fetchDogBreed(breedName: breed, completion: { [weak self] (result: Result<DogBreedModel, ErrorManager>) in
            switch result {
            case .success(let layoutViewModel):
                let images = DogBreedLayoutViewModel(dogBreed: layoutViewModel).message
                self?.layoutViewModel = images
                completion(.success(true))
            case .failure(let error):
                completion(.failure(.parser(string: error.localizedDescription)))
            }
        })
        
    }
    
}
