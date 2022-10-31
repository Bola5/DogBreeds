//
//  DogBreedLayoutViewModel.swift
//  DogBreeds
//
//  Created by Bola Fayez on 31/10/2022.
//

import Foundation

struct DogBreedLayoutViewModel {
    
    let message: [String]
        
    init(dogBreed: DogBreedModel) {
        
        self.message = dogBreed.message
    }

}
