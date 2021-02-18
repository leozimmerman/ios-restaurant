//
//  RestaurantViewController.swift
//  Restaurant
//
//  Created by Leonardo Zimmerman on 17/02/2021.
//  Copyright © 2021 Leonardo Zimmerman. All rights reserved.
//

import UIKit

final class RestaurantViewController: UIViewController {
    
    private var restaurant: Restaurant?
    
    // MARK: UI objects
    private let activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        indicator.hidesWhenStopped = true
        return indicator
    }()
    
    private let collectionView: UICollectionView = {
        let layout: UICollectionViewFlowLayout = VerticalCustomFlowLayout()
        layout.scrollDirection = .vertical
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        layout.minimumLineSpacing = 0
        
        let collection = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collection.contentInsetAdjustmentBehavior = .never
        return collection
    }()
    
    private let bookButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemGreen
        button.setTitle("Book a table", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        button.isHidden = true
        return button
    }()
    
    // MARK: View life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(white: 0.95, alpha: 1.0)
        setupNavigationBar()
        addLoader()
        addAndSetupCollection()
        addBookButton()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        fetchRestaurantData()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        bookButton.layer.cornerRadius = bookButton.frame.height / 2
        bookButton.clipsToBounds = true
    }
}

// MARK: Privates
private extension RestaurantViewController {
    func fetchRestaurantData() {
        startLoader()
        DataProvider.fetchRestaurantData { [weak self] restaurant in
            DispatchQueue.main.async {
                self?.stopLoader()
                if let resto = restaurant {
                    self?.loadRestaurant(resto)
                } else {
                    self?.showErrorAlert(message: "An error ocurred retrieving data from the server.")
                }
            }
        }
    }
    
    func loadRestaurant(_ restaurant: Restaurant) {
        self.restaurant = restaurant
        collectionView.reloadData()
    }
    
    func setupNavigationBar() {
        let shareImage = UIImage(named: "share")
        let shareImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 34, height: 34))
        shareImageView.image = shareImage
                
        let heartImage = UIImage(named: "solid-heart")
        let heartImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 34, height: 34))
        heartImageView.image = heartImage

        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 34, height: 34))
        button.setTitle("<", for: .normal)
        button.addTarget(self, action: #selector(self.goBack), for: .touchUpInside)

        [shareImageView, heartImageView, button].forEach {
            $0.backgroundColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.3)
            $0.contentMode = .center
            $0.layer.cornerRadius = 17.0
            $0.clipsToBounds = true
        }
        
        let shareItem = UIBarButtonItem(customView: shareImageView)
        let heartItem = UIBarButtonItem(customView: heartImageView)
        let backItem = UIBarButtonItem(customView: button)
        
        navigationItem.setRightBarButtonItems([heartItem, shareItem], animated: false)
        navigationItem.setLeftBarButton(backItem, animated: false)
    }
    
    func addAndSetupCollection() {
        collectionView.backgroundColor = .clear
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.register(PicturesSliderCell.self, forCellWithReuseIdentifier: PicturesSliderCell.reuseIdentifier)
        collectionView.register(InfoCell.self, forCellWithReuseIdentifier: InfoCell.reuseIdentifier)
        collectionView.register(MapCell.self, forCellWithReuseIdentifier: MapCell.reuseIdentifier)
        
        view.addSubview(collectionView)
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            collectionView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            collectionView.widthAnchor.constraint(equalTo: view.widthAnchor),
            collectionView.heightAnchor.constraint(equalTo: view.heightAnchor)
        ])
    }
    
    func addBookButton() {
        view.addSubview(bookButton)
        bookButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            bookButton.heightAnchor.constraint(equalToConstant: 40),
            bookButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            bookButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            bookButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
        ])
    }
    
    func addLoader() {
        view.addSubview(activityIndicator)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            activityIndicator.widthAnchor.constraint(equalToConstant: 20),
            activityIndicator.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
    
    func startLoader() {
        activityIndicator.startAnimating()
        bookButton.isHidden = true
    }
    
    func stopLoader() {
        activityIndicator.stopAnimating()
        bookButton.isHidden = false
    }
    
    @objc
    func goBack() {
        navigationController?.popViewController(animated: true)
    }
    
    func showErrorAlert(message: String) {
        let alertController = UIAlertController.createErrorAlertController(withMessage: message)
        self.present(alertController, animated: true, completion: nil)
    }
}

extension RestaurantViewController: UICollectionViewDelegate {}

extension RestaurantViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return restaurant == nil ? 0 : 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let restaurant = restaurant else {
            return UICollectionViewCell()
        }
        let row = indexPath.row
        if row == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PicturesSliderCell.reuseIdentifier,
                                                          for: indexPath)
            if let pictureCell = cell as? PicturesSliderCell {
                pictureCell.setup(with: restaurant)
                return pictureCell
            }
        } else if row == 1 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: InfoCell.reuseIdentifier,
                                                          for: indexPath)
            if let infoCell = cell as? InfoCell {
                infoCell.setup(with: restaurant)
                return infoCell
            }
        } else if row == 2 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MapCell.reuseIdentifier,
                                                          for: indexPath)
            if let mapCell = cell as? MapCell {
                mapCell.setup(with: restaurant)
                return mapCell
            }
        }
        return UICollectionViewCell()
    }
}



