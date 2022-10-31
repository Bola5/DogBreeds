//
//  FavViewController.swift
//  DogBreeds
//
//  Created by Bola Fayez on 31/10/2022.
//

import UIKit

class FavViewController: UIViewController {

    // MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
    }
    
    // MARK: - setupViews
    private func setupViews() {
        
        view.backgroundColor = .white
        title = "Favorites"
        
    }

}
