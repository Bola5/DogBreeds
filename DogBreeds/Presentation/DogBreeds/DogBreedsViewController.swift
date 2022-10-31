//
//  DogBreedsViewController.swift
//  DogBreeds
//
//  Created by Bola Fayez on 25/10/2022.
//

import UIKit

class DogBreedsViewController: UIViewController {

//    let dataSource: DogBreedsDataSourceProtocol = DogBreedsDataSource()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        
        setupViews()
        
//        dataSource.fetchDogBreedsList(completion: { result in
//            switch result {
//            case .success(let model):
//                let array = model.message?.map({ $0.key })
//                print(array?.sorted())
//            case .failure(let error):
//                print(error)
//            }
//        })
    }
    
    // MARK: - setupViews
    private func setupViews() {
        
        view.backgroundColor = .white
        title = "Dog Breeds"
    }


}

