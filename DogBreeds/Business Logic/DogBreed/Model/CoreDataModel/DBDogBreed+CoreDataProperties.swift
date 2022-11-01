//
//  DBDogBreed+CoreDataProperties.swift
//  DogBreeds
//
//  Created by Bola Fayez on 01/11/2022.
//
//

import Foundation
import CoreData


extension DBDogBreed {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<DBDogBreed> {
        return NSFetchRequest<DBDogBreed>(entityName: "DBDogBreed")
    }

    @NSManaged public var breedName: String?
    @NSManaged public var imageBreed: String?

}

extension DBDogBreed : Identifiable {

}
