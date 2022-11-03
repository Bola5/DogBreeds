//
//  FavoriteItemCollectionViewCell.swift
//  DogBreeds
//
//  Created by Bola Fayez on 02/11/2022.
//

import UIKit

class FavoriteItemCollectionViewCell: UICollectionViewCell {
    
    // MARK: - UI
    private let containerView = UIView()
    private let breedNameLbl = UILabel()

    // MARK: - Properties
    private var breedIndex: Int?
    private var onSelect: ((Int) -> Void)?

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
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 4),
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -4)
        ])
        containerView.layer.cornerRadius = 12
        containerView.clipsToBounds = true
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(selectedBreed(tapGestureRecognizer:)))
        containerView.isUserInteractionEnabled = true
        containerView.addGestureRecognizer(tapGestureRecognizer)
        
        // breedNameLbl
        breedNameLbl.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(breedNameLbl)
        NSLayoutConstraint.activate([
            breedNameLbl.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 4),
            breedNameLbl.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -4),
            breedNameLbl.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 8),
            breedNameLbl.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -8)
        ])
        breedNameLbl.font = UIFont.boldSystemFont(ofSize: 14)
        breedNameLbl.textAlignment = .center
    }
    
    // MARK: - Selected action
    @objc func selectedBreed(tapGestureRecognizer: UITapGestureRecognizer) {
        self.onSelect?(breedIndex ?? 0)
    }
    
}

// MARK: - Load Data
extension FavoriteItemCollectionViewCell {
    
    func loadViewWithLayoutViewModel(favoriteBreed: FavoriteLayoutViewModel?, breedIndex: Int, isSelected: Bool, onSelect: ((Int) -> Void)?) {
        guard let favoriteBreed = favoriteBreed else { return }
        
        self.breedIndex = breedIndex
        self.breedNameLbl.text = favoriteBreed.breedName
        self.containerView.backgroundColor = isSelected ? .darkGray : .lightGray
        self.breedNameLbl.textColor = isSelected ? .white : .black
        self.onSelect = onSelect
    }
    
}
