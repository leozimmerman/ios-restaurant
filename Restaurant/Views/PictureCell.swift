//
//  PictureCell.swift
//  Restaurant
//
//  Created by Leonardo Zimmerman on 17/02/2021.
//  Copyright © 2021 Leonardo Zimmerman. All rights reserved.
//

import UIKit

protocol PictureCellDelegate: AnyObject {
    func didLoadImage()
}

final class PictureCell: UICollectionViewCell {
    static let reuseIdentifier = "PictureCell"
    
    private let imageView = UIImageView()
    private weak var delegate: PictureCellDelegate?
    private let placeholder = UIImage(named: "imageBlack")
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
        addImageView()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = placeholder
        delegate = nil
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
        let targetSize = CGSize(width: 0, height: layoutAttributes.frame.height)
        layoutAttributes.frame.size = contentView.systemLayoutSizeFitting(targetSize,
                                                                          withHorizontalFittingPriority: .fittingSizeLevel,
                                                                          verticalFittingPriority: .required)
        return layoutAttributes
    }
    
    func setup(with imagePath: String, delegate: PictureCellDelegate) {
        self.delegate = delegate
        DataProvider.getImage(urlString: imagePath) { [weak self] image in
            DispatchQueue.main.async {
                self?.imageView.image = image
                self?.delegate?.didLoadImage()
            }
        }
    }
    
    private func addImageView() {
        contentView.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            imageView.widthAnchor.constraint(equalTo: contentView.widthAnchor),
            imageView.heightAnchor.constraint(equalTo: contentView.heightAnchor)
        ])
    }
}
