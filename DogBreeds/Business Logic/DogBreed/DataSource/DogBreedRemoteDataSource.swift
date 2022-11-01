//
//  DogBreedRemoteDataSource.swift
//  DogBreeds
//
//  Created by Bola Fayez on 31/10/2022.
//

import Foundation

protocol DogBreedRemoteDataSourceProtocol {
    func fetchDogBreed(breedName: String, completion: @escaping (Result<DogBreedModel, ErrorManager>) -> Void)
}

class DogBreedRemoteDataSource: DogBreedRemoteDataSourceProtocol {
    
    private let communicationManagerProtocol: CommunicationManagerProtocol
    
    init(communicationManagerProtocol: CommunicationManagerProtocol = CommunicationManager()) {
        self.communicationManagerProtocol = communicationManagerProtocol
    }

    func fetchDogBreed(breedName: String, completion: @escaping (Result<DogBreedModel, ErrorManager>) -> Void) {
        communicationManagerProtocol.request(urlString: EndPoints.fetchDogBreedImages(breedName: breedName).asRequest(), completion: { (result : Result<DogBreedModel, ErrorManager>) in
            switch result {
                case .success(let model):
                completion(.success(model))
                case .failure(let error):
                completion(.failure(error))
            }
        })
    }
    
}
