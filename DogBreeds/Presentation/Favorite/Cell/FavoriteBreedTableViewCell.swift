//
//  FavoriteBreedTableViewCell.swift
//  DogBreeds
//
//  Created by Bola Fayez on 02/11/2022.
//

import UIKit

class FavoriteBreedTableViewCell: UITableViewCell {

    // MARK: - UI
    private let containerView = UIView()
    private let breedImageView = UIImageView()
    
    // MARK: - Init
    // Cell style
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupViews()
    }
    
    // MARK: - With a coder
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - setupViews
    private func setupViews() {
        
        selectionStyle = .none
        
        // containerView
        containerView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(containerView)
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor),
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            containerView.heightAnchor.constraint(equalToConstant: 158)
        ])
        
        // breedImageView
        breedImageView.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(breedImageView)
        NSLayoutConstraint.activate([
            breedImageView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            breedImageView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            breedImageView.heightAnchor.constraint(equalToConstant: 150),
            breedImageView.widthAnchor.constraint(equalToConstant: 150)
        ])
        breedImageView.layer.cornerRadius = 16
        breedImageView.clipsToBounds = true
        
    }

}

// MARK: - Load data
extension FavoriteBreedTableViewCell {
    
    func loadDataWithLayoutViewModel(imageURL: String?) {
        guard let imageURL = imageURL else { return }
        
        breedImageView.loadImageWith(url: imageURL, contentMode: .scaleToFill)
    }
    
}
