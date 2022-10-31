//
//  DogBreedsTableViewCell.swift
//  DogBreeds
//
//  Created by Bola Fayez on 31/10/2022.
//

import UIKit

class DogBreedsTableViewCell: UITableViewCell {

    // MARK: - UI
    private let containerView = UIView()
    private let nameLbl = UILabel()
    
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
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
        
        // nameLbl
        nameLbl.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(nameLbl)
        NSLayoutConstraint.activate([
            nameLbl.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 16),
            nameLbl.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -16),
            nameLbl.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 18)
        ])
        nameLbl.font = UIFont.boldSystemFont(ofSize: 16)
        nameLbl.textColor = .black
    }

}

// MARK: - loadViewWithLayoutViewModel
extension DogBreedsTableViewCell {
    
    func loadViewWithLayoutViewModel(breedName: String) {
        
        self.nameLbl.text = breedName
    }
    
}
