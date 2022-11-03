//
//  BogBreedAPITests.swift
//  DogBreedsTests
//
//  Created by Bola Fayez on 03/11/2022.
//

import XCTest
@testable import DogBreeds

class BogBreedAPITests: CommunicationManagerProtocol {
    
    let data: DogBreedModel?
    let error: Error?
    
    init(data: DogBreedModel? = nil, error: Error? = nil) {
        self.data = data
        self.error = error
    }
    
    func request<T>(urlString: String, completion: @escaping (Result<T, ErrorManager>) -> Void) where T : Decodable, T : Encodable {
        if let data = data as? T {
            completion(.success(data))
        } else if let error = error {
            completion(.failure(.parser(string: error.localizedDescription)))
        } else {
            let error = NSError(domain: "Missed mock", code: 1000, userInfo: [NSLocalizedDescriptionKey : "You missed pass the mocked data"])
            completion(.failure(.parser(string: error.localizedDescription)))
        }
    }

}
