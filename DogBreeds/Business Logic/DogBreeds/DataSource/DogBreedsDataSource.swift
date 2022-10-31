//
//  DogBreedsDataSource.swift
//  DogBreeds
//
//  Created by Bola Fayez on 25/10/2022.
//

import Foundation

protocol DogBreedsDataSourceProtocol {
    func fetchDogBreedsList(completion: @escaping (Result<DogBreedsModel, ErrorManager>) -> Void)
}

class DogBreedsDataSource: DogBreedsDataSourceProtocol {
    
    private let communicationManagerProtocol: CommunicationManagerProtocol
    
    init(communicationManagerProtocol: CommunicationManagerProtocol = CommunicationManager()) {
        self.communicationManagerProtocol = communicationManagerProtocol
    }

    func fetchDogBreedsList(completion: @escaping (Result<DogBreedsModel, ErrorManager>) -> Void) {
        communicationManagerProtocol.request(urlString: EndPoints.fetchDogBreedsList.asRequest(), completion: { (result : Result<DogBreedsModel, ErrorManager>) in
            switch result {
                case .success(let model):
                completion(.success(model))
                case .failure(let error):
                completion(.failure(error))
            }
        })
    }
    
}
