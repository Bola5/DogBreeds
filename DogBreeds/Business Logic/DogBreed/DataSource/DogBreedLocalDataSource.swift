//
//  DogBreedLocalDataSource.swift
//  DogBreeds
//
//  Created by Bola Fayez on 01/11/2022.
//

import Foundation

protocol DogBreedLocalDataSourceProtocol {
    func saveBreed(breedName: String, breed: DogBreedLayoutViewModel.DogBreedImageLayoutViewModel)
    func deleteBreed(dbBreed: DBDogBreed)
    func loadBreeds() -> [DogBreedLayoutViewModel.DogBreedImageLayoutViewModel]
}

class DogBreedLocalDataSource: DogBreedLocalDataSourceProtocol {

    func saveBreed(breedName: String, breed: DogBreedLayoutViewModel.DogBreedImageLayoutViewModel) {
        _ = DBDogBreed.convertFrom(breedName: breedName, breed: breed)
        DatabaseManager.sharedInstance.save()
    }
    
    func deleteBreed(dbBreed: DBDogBreed) {
        DatabaseManager.sharedInstance.delete(object: dbBreed)
        
        DatabaseManager.sharedInstance.save()
    }
    
    func loadBreeds() -> [DogBreedLayoutViewModel.DogBreedImageLayoutViewModel] {
        var layoutViewModel = [DogBreedLayoutViewModel.DogBreedImageLayoutViewModel]()

        let breeds = DatabaseManager.sharedInstance.getAllEntries(of: DBDogBreed.self)
        for breed in breeds {
            layoutViewModel.append(convertFrom(dbBreed: breed))
        }
        
        return layoutViewModel
    }
    
    private func convertFrom(dbBreed: DBDogBreed) -> DogBreedLayoutViewModel.DogBreedImageLayoutViewModel {
        return DogBreedLayoutViewModel.DogBreedImageLayoutViewModel(breedName: dbBreed.breedName ?? "", imageURL: dbBreed.imageBreed ?? "")
    }
    
}
