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

    struct DogBreedImageLayoutViewModel {
        let imageURL: String
        let isFav: Bool
    }
    
}

// MARK: - Get The Breed Images With Fav
extension DogBreedLayoutViewModel {

    func getTheBreedImagesWithFav() -> [DogBreedImageLayoutViewModel]? {
        return self.message.compactMap({ DogBreedImageLayoutViewModel(imageURL: $0, isFav: false) })
    }
    
}
