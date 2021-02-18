//
//  InfoCell.swift
//  Restaurant
//
//  Created by Leonardo Zimmerman on 17/02/2021.
//  Copyright © 2021 Leonardo Zimmerman. All rights reserved.
//

import UIKit

final class InfoCell: UICollectionViewCell {
    static let reuseIdentifier = "InfoCell"
    
    let whiteContainer = UIView()
    let middleStackView = InfoStackView()
    let ratingStackView = RatingStackView()
    let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .left
        label.font = UIFont.boldSystemFont(ofSize: 30)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
        addUIComponents()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
        let layoutAttributes = super.preferredLayoutAttributesFitting(layoutAttributes)
        layoutIfNeeded()
        var newFrame = layoutAttributes.frame
        newFrame.size.height = 310
        layoutAttributes.frame = newFrame
        return layoutAttributes
    }
    
    func setup(with restaurant: Restaurant) {
        titleLabel.text = restaurant.name
        middleStackView.setup(address: restaurant.address,
                              speciality: restaurant.speciality,
                              price: restaurant.cardPrice)
        ratingStackView.setup(rateCount: restaurant.rateCount,
                              averageRate: restaurant.averageRate,
                              tripAdvisorRateCount: restaurant.tripAdvisorRateCount,
                              tripAdvisorAverageRate: restaurant.tripAdvisorAverageRate)
    }
}

// MARK: Privates
private extension InfoCell {
    func addUIComponents() {
        whiteContainer.backgroundColor = .white
        whiteContainer.setupRoundedCorners(radius: 60, corners: [.bottomRight, .bottomLeft])
        contentView.addSubview(whiteContainer)
        whiteContainer.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(middleStackView)
        middleStackView.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(ratingStackView)
        ratingStackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            whiteContainer.topAnchor.constraint(equalTo: contentView.topAnchor),
            whiteContainer.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            whiteContainer.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            whiteContainer.bottomAnchor.constraint(equalTo: ratingStackView.bottomAnchor, constant: 35),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            middleStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            middleStackView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            ratingStackView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            ratingStackView.leadingAnchor.constraint(greaterThanOrEqualTo: contentView.leadingAnchor, constant: 10),
            ratingStackView.trailingAnchor.constraint(lessThanOrEqualTo: contentView.trailingAnchor, constant: 10),
            ratingStackView.topAnchor.constraint(equalTo: middleStackView.bottomAnchor, constant: 40)
        ])
    }
}
