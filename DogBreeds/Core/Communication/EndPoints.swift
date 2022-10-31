//
//  EndPoints.swift
//  DogBreeds
//
//  Created by Bola Fayez on 25/10/2022.
//

import Foundation

enum EndPoints {
    
    case fetchDogBreedsList

    private var baseURLString: String { "https://dog.ceo/api/" }

    private var url: URL? {
        switch self {
        case .fetchDogBreedsList:
            return URL(string: baseURLString + "breeds/list/all")
        }
    }

    private var parameters: [URLQueryItem] {
        switch self {
        case .fetchDogBreedsList: return []
        }
    }

    func asRequest() -> String {
        guard let url = url else {
            preconditionFailure("Missing URL for route: \(self)")
        }

        var components = URLComponents(url: url, resolvingAgainstBaseURL: false)
        components?.queryItems = parameters

        guard let parametrizedURL = components?.url else {
            preconditionFailure("Missing URL with parameters for url: \(url)")
        }

        return parametrizedURL.absoluteString
    }
    
}
