//
//  CodableManager.swift
//  DogBreeds
//
//  Created by Bola Fayez on 25/10/2022.
//

import Foundation

struct CodableManager {

    static func decode<T: Decodable>(_ type: T.Type, from data: Data) throws -> T {
        let jsonDecoder = JSONDecoder()
        let jsonModel = try jsonDecoder.decode(type, from: data)
        return jsonModel
    }

}
