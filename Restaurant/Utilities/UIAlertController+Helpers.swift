//
//  UIAlertController+Helpers.swift
//  Restaurant
//
//  Created by Leonardo Zimmerman on 17/02/2021.
//  Copyright © 2021 Leonardo Zimmerman. All rights reserved.
//

import UIKit

extension UIAlertController {
    class func createErrorAlertController(withMessage message: String) -> UIAlertController {
        let alertController = UIAlertController(title: "Error", message:
            message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Accept", style: .default))
        return alertController
    }
}
