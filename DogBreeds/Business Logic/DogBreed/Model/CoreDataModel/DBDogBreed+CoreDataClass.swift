//
//  DBDogBreed+CoreDataClass.swift
//  DogBreeds
//
//  Created by Bola Fayez on 01/11/2022.
//
//

import Foundation
import CoreData

@objc(DBDogBreed)
public class DBDogBreed: NSManagedObject {

    // MARK: - Convert BreedLayoutViewModel to DBBreedModel
    static func convertFrom(breedName: String, breed: DogBreedLayoutViewModel.DogBreedImageLayoutViewModel) -> DBDogBreed {
        
        var dbBreed: DBDogBreed
        if let existingBreed = DatabaseManager.sharedInstance.loadAllEntries(of: DBDogBreed.self, predicate: .equals(\.imageBreed, breed.imageURL)).first {
            dbBreed = existingBreed
        } else {
            dbBreed = DatabaseManager.sharedInstance.createManagedObject(of: DBDogBreed.self)
        }
        
        dbBreed.imageBreed = breed.imageURL
        dbBreed.breedName = breedName
        
        return dbBreed
    }

    
}
