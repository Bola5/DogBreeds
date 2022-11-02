//
//  DogBreedRepository.swift
//  DogBreeds
//
//  Created by Bola Fayez on 01/11/2022.
//

import Foundation

protocol DogBreedRepositoryProtocol {
    
    //MARK: - Protocol - DataBase
    func addFav(breedName: String, breed: DogBreedLayoutViewModel.DogBreedImageLayoutViewModel)
    func removeFav(breedName: String, breed: DogBreedLayoutViewModel.DogBreedImageLayoutViewModel)
    func getAllFavBreed() -> [DogBreedLayoutViewModel.DogBreedImageLayoutViewModel]
    
    //MARK: - Protocol - Fetch
    func fetchDogBreedImages(breedName: String, completion: @escaping DogBreedRepository.GetDogBreedImagesCompletionBlock)
}

class DogBreedRepository: DogBreedRepositoryProtocol {

    // MARK: - Callback type alias
    typealias GetDogBreedImagesCompletionBlock = (Result<DogBreedLayoutViewModel, ErrorManager>) -> Void

    // MARK: - Properties
    // Data Source
    private let remoteDataSource: DogBreedRemoteDataSourceProtocol
    private let localDataSource: DogBreedLocalDataSourceProtocol

    // Init
    init(remoteDataSource: DogBreedRemoteDataSourceProtocol = DogBreedRemoteDataSource(), localDataSource: DogBreedLocalDataSourceProtocol = DogBreedLocalDataSource()) {
        
        self.remoteDataSource = remoteDataSource
        self.localDataSource = localDataSource
    }
    
}

// MARK: - Protocol - fetch
extension DogBreedRepository {
    
    func fetchDogBreedImages(breedName: String, completion: @escaping GetDogBreedImagesCompletionBlock) {
        remoteDataSource.fetchDogBreed(breedName: breedName, completion: { (result: Result<DogBreedModel, ErrorManager>) in
            switch result {
            case .success(let layoutViewModel):
                completion(.success(DogBreedLayoutViewModel(dogBreed: layoutViewModel)))
            case .failure(let error):
                completion(.failure(.parser(string: error.localizedDescription)))
            }
        })
        
    }
    
}

// MARK: - Protocol - database
extension DogBreedRepository {
    
    func addFav(breedName: String, breed: DogBreedLayoutViewModel.DogBreedImageLayoutViewModel) {
        localDataSource.saveBreed(breedName: breedName, breed: breed)
    }
    
    func removeFav(breedName: String, breed: DogBreedLayoutViewModel.DogBreedImageLayoutViewModel) {
        let dbBreed = DBDogBreed.convertFrom(breedName: breedName, breed: breed)
        localDataSource.deleteBreed(dbBreed: dbBreed)
    }
    
    func getAllFavBreed() -> [DogBreedLayoutViewModel.DogBreedImageLayoutViewModel] {
        return localDataSource.loadBreeds()
    }
    
}
