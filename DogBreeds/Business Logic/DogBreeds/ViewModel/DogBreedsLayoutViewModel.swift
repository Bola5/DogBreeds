//
//  DogBreedsLayoutViewModel.swift
//  DogBreeds
//
//  Created by Bola Fayez on 25/10/2022.
//

import Foundation

struct DogBreedsLayoutViewModel {
    
    let message: [String: [String]?]?
    
    init(dogBreeds: DogBreedsModel) {
        
        self.message = dogBreeds.message
    }

}

extension DogBreedsLayoutViewModel {
    
    func getAvailableBreeds() -> [String] {
        guard let availableBreeds = self.message?.map({ $0.key }).sorted() else { return [] }
        return availableBreeds
    }
    
}
