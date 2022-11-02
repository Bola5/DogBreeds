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
    private let favButton = UIButton()
    
    // MARK: - Action
    private var onActionEvent: ((DogBreedAction) -> Void)?
    private var onSelectFav: ((Bool) -> Void)?

    // MARK: - Properties
    private var breedImage: DogBreedLayoutViewModel.DogBreedImageLayoutViewModel?
    
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
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        breedImageView.isUserInteractionEnabled = true
        breedImageView.addGestureRecognizer(tapGestureRecognizer)
        
        // favButton
        favButton.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(favButton)
        NSLayoutConstraint.activate([
            favButton.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 8),
            favButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -8),
            favButton.heightAnchor.constraint(equalToConstant: 30),
            favButton.widthAnchor.constraint(equalToConstant: 30)
        ])
        favButton.setImage(UIImage(named: "unFav"), for: .normal)
        favButton.setImage(UIImage(named: "fav"), for: .selected)
        favButton.addTarget(self, action: #selector(addOrRemoveFromFavAction), for: .touchUpInside)

    }
    
    // MARK: - addOrRemoveFromFavAction
    @objc func addOrRemoveFromFavAction(sender: UIButton) {
        addOrRemoveFromFav()
    }
    
    @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer) {
        addOrRemoveFromFav()
    }
    
    func addOrRemoveFromFav() {
        self.favButton.isSelected = !(self.favButton.isSelected)
        self.onSelectFav?(self.favButton.isSelected)
        self.onActionEvent?(.addOrRemoveFromFav(imageURL: self.breedImage?.imageURL ?? "", isFav: self.favButton.isSelected))
    }
    
}

// MARK: - Load data
extension DogBreedImageCollectionViewCell {
    
    func loadDataWithLayoutViewModel(breedImage: DogBreedLayoutViewModel.DogBreedImageLayoutViewModel?, onAction: ((DogBreedAction) -> Void)?, onSelectFav: ((Bool) -> Void)?) {
        guard let breedImage = breedImage else { return }
        
        self.onActionEvent = onAction
        self.onSelectFav = onSelectFav
        self.breedImage = breedImage
        self.favButton.isSelected = self.breedImage?.isFav ?? false
        self.breedImageView.loadImageWith(url: self.breedImage?.imageURL ?? "", contentMode: .scaleToFill)
        self.setupImageShap()
    }
    
    private func setupImageShap() {
        
        self.breedImageView.layer.cornerRadius = 16
        self.breedImageView.clipsToBounds = true
    }
    
}

