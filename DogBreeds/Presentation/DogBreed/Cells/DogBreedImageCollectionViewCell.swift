//
//  DogBreedImageCollectionViewCell.swift
//  DogBreeds
//
//  Created by Bola Fayez on 31/10/2022.
//

import UIKit

class DogBreedImageCollectionViewCell: UICollectionViewCell {
    
    // MARK: - UI
    private let containerView = UIView()
    private let breedImageView = UIImageView()
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: -  setupViews
    private func setupViews() {
        
        // containerView
        containerView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(containerView)
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor),
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])

        // breedImageView
        breedImageView.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(breedImageView)
        NSLayoutConstraint.activate([
            breedImageView.topAnchor.constraint(equalTo: containerView.topAnchor),
            breedImageView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
            breedImageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            breedImageView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor)
        ])
    }
    
}

// MARK: - Load data
extension DogBreedImageCollectionViewCell {
    
    func loadDataWithLayoutViewModel(image: String?) {
        guard let image = image else { return }
        
        self.breedImageView.loadImageWith(url: image, contentMode: .scaleToFill)
        setupImageShap()
    }
    
    private func setupImageShap() {
        
        self.breedImageView.layer.cornerRadius = 16
        self.breedImageView.clipsToBounds = true
    }
    
}

