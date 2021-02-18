//
//  InfoStackView.swift
//  Restaurant
//
//  Created by Leonardo Zimmerman on 17/02/2021.
//  Copyright © 2021 Leonardo Zimmerman. All rights reserved.
//

import UIKit

final class InfoStackView: UIStackView {
    let locationImageView: UIImageView = {
        let image = UIImage(named: "location")
        let imageView = UIImageView(image: image)
        imageView.contentMode = .center
        imageView.backgroundColor = UIColor(red: 0, green: 1, blue: 0, alpha: 0.1)
        return imageView
    }()
    
    let foodImageView: UIImageView = {
        let image = UIImage(named: "food")
        let imageView = UIImageView(image: image)
        imageView.contentMode = .center
        imageView.backgroundColor = UIColor(red: 0, green: 1, blue: 0, alpha: 0.1)
        return imageView
    }()
    
    let cashImageView: UIImageView = {
        let image = UIImage(named: "cash")
        let imageView = UIImageView(image: image)
        imageView.contentMode = .center
        imageView.backgroundColor = UIColor(red: 0, green: 1, blue: 0, alpha: 0.1)
        return imageView
    }()
    
    let locationLabel: UILabel = {
        let label = UILabel()
        label.textColor = .gray
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 15)
        return label
    }()
    
    let foodLabel: UILabel = {
        let label = UILabel()
        label.textColor = .gray
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 15)
        return label
    }()
    
    let cashLabel: UILabel = {
        let label = UILabel()
        label.textColor = .gray
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 15)
        return label
    }()
    
    init() {
        super.init(frame: CGRect.zero)
        
        let locationStack: UIStackView = {
            let stack = UIStackView(arrangedSubviews: [locationImageView, locationLabel])
            stack.axis = .horizontal
            stack.spacing = 15
            return stack
        }()
        
        let foodStack: UIStackView = {
            let stack = UIStackView(arrangedSubviews: [foodImageView, foodLabel])
            stack.axis = .horizontal
            stack.spacing = 15
            return stack
        }()
        
        let cashStack: UIStackView = {
            let stack = UIStackView(arrangedSubviews: [cashImageView, cashLabel])
            stack.axis = .horizontal
            stack.spacing = 15
            return stack
        }()
        
        axis = .vertical
        spacing = 15
        addArrangedSubview(locationStack)
        addArrangedSubview(foodStack)
        addArrangedSubview(cashStack)
        
        NSLayoutConstraint.activate([
            locationImageView.widthAnchor.constraint(equalToConstant: 20),
            foodImageView.widthAnchor.constraint(equalToConstant: 20),
            cashImageView.widthAnchor.constraint(equalToConstant: 20)
        ])
    }
    
    func setup(address: String, speciality: String, price: Int) {
        locationLabel.text = address
        foodLabel.text = speciality
        cashLabel.text = "Average price €\(price)"
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
