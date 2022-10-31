//
//  CommunicationManager.swift
//  DogBreeds
//
//  Created by Bola Fayez on 25/10/2022.
//

import Foundation

protocol CommunicationManagerProtocol {
    func request<T: Codable>(urlString: String, completion: @escaping (Result<T, Error>) -> Void)
}

class CommunicationManager: CommunicationManagerProtocol {

    func request<T: Codable>(urlString: String, completion: @escaping (Result<T, Error>) -> Void) {
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            if let error = error {
                completion(.failure(error)); return
            }
            if let data = data {
                do {
                    let data = try CodableManager.decode(T.self, from: data)
                    completion(.success(data))
                } catch {
                    completion(.failure(error))
                }
            }
        }.resume()
    }
    
}
