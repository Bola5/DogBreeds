//
//  FavoriteFlowLayout.swift
//  DogBreeds
//
//  Created by Bola Fayez on 02/11/2022.
//

import UIKit

class FavoriteFlowLayout: UICollectionViewFlowLayout {

    override init() {
        super.init()
        
        scrollDirection = .horizontal
        estimatedItemSize = UICollectionViewFlowLayout.automaticSize
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
