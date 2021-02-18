//
//  MapCell.swift
//  Restaurant
//
//  Created by Leonardo Zimmerman on 17/02/2021.
//  Copyright © 2021 Leonardo Zimmerman. All rights reserved.
//

import UIKit
import MapKit

final class MapCell: UICollectionViewCell {
    static let reuseIdentifier = "MapCell"
    
    let mapView = MKMapView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
        addMapview()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
        let location: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: restaurant.latitude,
                                                                      longitude: restaurant.longitude)
        addAnnotation(location)
        centerToLocation(location)
    }
}

private extension MapCell {
    func addAnnotation(_ location: CLLocationCoordinate2D) {
        let annotation = MKPointAnnotation()
        annotation.coordinate = location
        mapView.addAnnotation(annotation)
    }
    
    func centerToLocation(_ location: CLLocationCoordinate2D) {
        let regionRadiusMeters: CLLocationDistance = 150
        let coordinateRegion = MKCoordinateRegion(center: location, latitudinalMeters: regionRadiusMeters,
                                                  longitudinalMeters: regionRadiusMeters)
        mapView.setRegion(coordinateRegion, animated: false)
    }
    
    func addMapview() {
        mapView.isUserInteractionEnabled = false
        contentView.addSubview(mapView)
        mapView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            mapView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            mapView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            mapView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0),
            mapView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
}
