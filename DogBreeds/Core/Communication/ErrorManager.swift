//
//  ErrorManager.swift
//  DogBreeds
//
//  Created by Bola Fayez on 25/10/2022.
//

import Foundation

enum ErrorManager: Error {
    
    case parser(string: String?)
    
    func getStringError() -> String? {
        switch self {
        case .parser(let string):
            return(string)
        }
    }
}
