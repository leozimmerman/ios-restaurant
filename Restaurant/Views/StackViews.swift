//
//  StackViews.swift
//  Restaurant
//
//  Created by Leonardo Zimmerman on 17/02/2021.
//  Copyright © 2021 Leonardo Zimmerman. All rights reserved.
//

import UIKit

// MARK: - RatingStackView
final class RatingStackView: UIStackView {
    let reviewsStackView = ReviewsStackView()
    let tripStackView = TripAdvisorStackView()
    
    init() {
        super.init(frame: CGRect.zero)
        axis = .horizontal
        distribution = .fillProportionally
        alignment = .center
        spacing = 20
        
        let separator: UIView = {
            let view = UIView()
            view.backgroundColor = .lightGray
            return view
        }()
        
        addArrangedSubview(reviewsStackView)
        addArrangedSubview(separator)
        addArrangedSubview(tripStackView)
        
        NSLayoutConstraint.activate([
            separator.widthAnchor.constraint(equalToConstant: 1),
            separator.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.7)
        ])
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(rateCount: Int,
               averageRate: Double,
               tripAdvisorRateCount: Int,
               tripAdvisorAverageRate: Double) {
        reviewsStackView.setup(rateCount: rateCount,
                               averageRate: averageRate)
        tripStackView.setup(tripRateCount: tripAdvisorRateCount,
                            tripAverageRate: tripAdvisorAverageRate)
    }
}

// MARK: - TripAdvisorStackView
final class TripAdvisorStackView: UIStackView  {
    let tripImageView: UIImageView = {
        let image = UIImage(named: "ta-logo")
        let imageView = UIImageView(image: image)
        return imageView
    }()
    
    let bubblesStackview: BubblesStackView = BubblesStackView()
    
    let reviewsLabel: UILabel = {
        let label = UILabel()
        label.textColor = .gray
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 12)
        return label
    }()
   
    init() {
        super.init(frame: CGRect.zero)
        
        let topStack: UIStackView = {
            let stack = UIStackView(arrangedSubviews: [tripImageView, bubblesStackview])
            stack.axis = .horizontal
            stack.spacing = 15
            return stack
        }()
        
        axis = .vertical
        spacing = 15
        alignment = .center
        
        addArrangedSubview(topStack)
        addArrangedSubview(reviewsLabel)
        
        NSLayoutConstraint.activate([
            tripImageView.widthAnchor.constraint(equalToConstant: 40),
            tripImageView.heightAnchor.constraint(equalToConstant: 25)
        ])
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(tripRateCount: Int, tripAverageRate: Double) {
        reviewsLabel.text = "\(tripRateCount) TripAdvisor reviews"
        bubblesStackview.setup(rate: tripAverageRate)
    }
}

// MARK: - BubblesStackView
final class BubblesStackView: UIStackView {
    let fullImage = UIImage(named: "ta-bubbles-full")
    let halfImage = UIImage(named: "ta-bubbles-half")
    let emptyImage = UIImage(named: "ta-bubbles-empty")
    
    var bubblesImageViews: [UIImageView] = []
    
    private let bubblesCount = 5
    
    init() {
        super.init(frame: CGRect.zero)
        
        axis = .horizontal
        spacing = 5
        alignment = .center
        distribution = .equalSpacing
        
        for _ in 0..<bubblesCount {
            let imageView = UIImageView()
            bubblesImageViews.append(imageView)
            addArrangedSubview(imageView)
            NSLayoutConstraint.activate([
                imageView.widthAnchor.constraint(equalToConstant: 15),
                imageView.heightAnchor.constraint(equalToConstant: 15)
            ])
        }
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(rate: Double) {
        guard bubblesImageViews.count == bubblesCount else { return }
        for i in 0..<bubblesCount {
            if rate >= Double(i)+1 {
                bubblesImageViews[i].image = fullImage
            } else if rate > Double(i) {
                bubblesImageViews[i].image = halfImage
            } else {
                bubblesImageViews[i].image = emptyImage
            }
        }
    }
}

// MARK: - ReviewsStackView
final class ReviewsStackView: UIStackView  {
    let forkImageView: UIImageView = {
        let image = UIImage(named: "tf-logo")
        let imageView = UIImageView(image: image)
        return imageView
    }()
    
    let rateLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .left
        label.font = UIFont.boldSystemFont(ofSize: 35)
        return label
    }()
    
    let reviewsLabel: UILabel = {
        let label = UILabel()
        label.textColor = .gray
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 12)
        return label
    }()
   
    init() {
        super.init(frame: CGRect.zero)
        
        let topStack: UIStackView = {
            let stack = UIStackView(arrangedSubviews: [forkImageView, rateLabel])
            stack.axis = .horizontal
            stack.spacing = 15
            return stack
        }()
        
        axis = .vertical
        spacing = 15
        alignment = .center
        
        addArrangedSubview(topStack)
        addArrangedSubview(reviewsLabel)
        
        NSLayoutConstraint.activate([
            forkImageView.widthAnchor.constraint(equalToConstant: 25),
            forkImageView.heightAnchor.constraint(equalToConstant: 25)
        ])
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(rateCount: Int, averageRate: Double) {
        reviewsLabel.text = "\(rateCount) TheFork reviews"
        
        let rateText = "\(averageRate)/10"
        let attributedString = NSMutableAttributedString(string: rateText, attributes: nil)
        let dontRange = (attributedString.string as NSString).range(of: "/10")
        attributedString.setAttributes([NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18)], range: dontRange)
        rateLabel.attributedText = attributedString
    }
}
