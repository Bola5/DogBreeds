//
//  DogBreedFlowLayout.swift
//  DogBreeds
//
//  Created by Bola Fayez on 31/10/2022.
//

import UIKit

class DogBreedFlowLayout: UICollectionViewFlowLayout {

    override init() {
        super.init()
        
        minimumInteritemSpacing = 16
        minimumLineSpacing = 16
        sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        scrollDirection = .horizontal
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
