//
//  HomeViewController.swift
//  Restaurant
//
//  Created by Leonardo Zimmerman on 17/02/2021.
//  Copyright © 2021 Leonardo Zimmerman. All rights reserved.
//

import UIKit

final class HomeViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        addAndSetupButton()
        navigationController?.navigationBar.setTranslucent()
    }
}

private extension HomeViewController {
    func addAndSetupButton() {
        let button = UIButton(type: .system)
        button.setTitle("Show Restaurant Detail", for: .normal)
        button.addTarget(self, action: #selector(self.showRestaurantDetail), for: .touchUpInside)
        
        button .translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(button)
        
        NSLayoutConstraint.activate([
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            button.widthAnchor.constraint(equalToConstant: 200),
            button.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    @objc
    func showRestaurantDetail() {
        let viewController = RestaurantViewController()
        navigationController?.pushViewController(viewController, animated: true)
    }
}

