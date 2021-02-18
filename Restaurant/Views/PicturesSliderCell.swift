//
//  PicturesSliderCell.swift
//  Restaurant
//
//  Created by Leonardo Zimmerman on 17/02/2021.
//  Copyright © 2021 Leonardo Zimmerman. All rights reserved.
//

import UIKit

final class PicturesSliderCell: UICollectionViewCell {
    static let reuseIdentifier = "PicturesSliderCell"
    
    private let collectionView: UICollectionView = {
        let layout: UICollectionViewFlowLayout = HorizontalCustomFlowLayout()
        layout.scrollDirection = .horizontal
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        let collection = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collection.contentInsetAdjustmentBehavior = .never
        return collection
    }()
    private let morePhotosButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor(white: 0, alpha: 0.5)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        return button
    }()
    private var picturesPaths: [String] = []
    private var hasLoadedFirstPic: Bool = false
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
        addCollectionView()
        addMorePhotosButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        morePhotosButton.layer.cornerRadius = morePhotosButton.frame.height / 2
        morePhotosButton.clipsToBounds = true
    }
    
    override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
        let layoutAttributes = super.preferredLayoutAttributesFitting(layoutAttributes)
        layoutIfNeeded()
        let size = contentView.systemLayoutSizeFitting(layoutAttributes.size)
        var newFrame = layoutAttributes.frame
        newFrame.size.height = size.width * 0.67
        layoutAttributes.frame = newFrame
        return layoutAttributes
      }
    
    func setup(with restaurant: Restaurant) {
        picturesPaths = restaurant.pictures
        morePhotosButton.setTitle("See all \(picturesPaths.count) photos >", for: .normal)
        collectionView.reloadData()
    }
}

// MARK: Privates
private extension PicturesSliderCell {
    func addCollectionView() {
        collectionView.register(PictureCell.self,
                                forCellWithReuseIdentifier: PictureCell.reuseIdentifier)
        collectionView.delegate = self
        collectionView.dataSource = self
        contentView.addSubview(collectionView)
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            collectionView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            collectionView.widthAnchor.constraint(equalTo: contentView.widthAnchor),
            collectionView.heightAnchor.constraint(equalTo: contentView.heightAnchor)
        ])
    }
    
    func addMorePhotosButton() {
        contentView.addSubview(morePhotosButton)
        morePhotosButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            morePhotosButton.heightAnchor.constraint(equalToConstant: 30),
            morePhotosButton.widthAnchor.constraint(equalToConstant: 150),
            morePhotosButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            morePhotosButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20),
        ])
    }
}

// MARK: Delegates
extension PicturesSliderCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return picturesPaths.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PictureCell.reuseIdentifier, for: indexPath) as! PictureCell
        let path = picturesPaths[indexPath.item]
        cell.setup(with: path, delegate: self)
        return cell
    }
}

extension PicturesSliderCell: UICollectionViewDelegate {}

extension PicturesSliderCell: PictureCellDelegate {
    func didLoadImage() {
        if !hasLoadedFirstPic {
            collectionView.collectionViewLayout.invalidateLayout()
            hasLoadedFirstPic = true
        }
    }
}
