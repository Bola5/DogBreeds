//
//  DogBreedsViewModel.swift
//  DogBreeds
//
//  Created by Bola Fayez on 25/10/2022.
//

import Foundation

protocol DogBreedsViewModelProtocol {
    
    //MARK: - Protocol - Data Source
    var countOfBreeds: Int { get }
    func breedAt(index: Int) -> String?
    func breedsBy(name: String) -> [String]
    
    // MARK: - Protocol - fetch
    func fetchDogBreedsList(completion: @escaping DogBreedsViewModel.GetDogBreedsListCompletionBlock)
}

class DogBreedsViewModel: DogBreedsViewModelProtocol {
        
    // MARK: - Callback type alias
    typealias GetDogBreedsListCompletionBlock = (Result<Bool, ErrorManager>) -> Void

    // MARK: - Properties
    // Data Source
    private let dogBreedsDataSource: DogBreedsRemoteDataSourceProtocol
    private var layoutViewModel: DogBreedsLayoutViewModel?
    
    var countOfBreeds: Int {
        return layoutViewModel?.message?.count ?? 0
    }
    
    // Init
    init(dogBreedsDataSource: DogBreedsRemoteDataSourceProtocol = DogBreedsRemoteDataSource()) {
        
        self.dogBreedsDataSource = dogBreedsDataSource
    }
    
}

// MARK: - Protocol - Data Source method
extension DogBreedsViewModel {
    
    // Breed at index
    func breedAt(index: Int) -> String? {
        return self.layoutViewModel?.getAvailableBreeds()[index].capitalized
    }
    
    // Breeds by name
    func breedsBy(name: String) -> [String] {
        guard let breeds = self.layoutViewModel?.message?[name] ?? [] else { return [] }
        return breeds
    }
    
}

// MARK: - Protocol - fetch
extension DogBreedsViewModel {
    
    func fetchDogBreedsList(completion: @escaping GetDogBreedsListCompletionBlock) {
        dogBreedsDataSource.fetchDogBreedsList(completion: { [weak self] (result: Result<DogBreedsModel, ErrorManager>) in
            switch result {
            case .success(let layoutViewModel):
                self?.layoutViewModel = DogBreedsLayoutViewModel(dogBreeds: layoutViewModel)
                completion(.success(true))
            case .failure(let error):
                completion(.failure(.parser(string: error.localizedDescription)))
            }
        })
        
    }
    
}
