//
//  DogBreedsModel.swift
//  DogBreeds
//
//  Created by Bola Fayez on 25/10/2022.
//

import Foundation

struct DogBreedsModel: Codable {
    
    let message: [String: [String]?]?
    let status: String
    
    enum CodingKeys: String, CodingKey {
        case message
        case status
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try values.decode(String.self, forKey: .status)
        message = try values.decodeIfPresent([String: [String]?].self, forKey: .message)
    }

}
