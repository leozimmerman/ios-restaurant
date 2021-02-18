//
//  APIManager.swift
//  Restaurant
//
//  Created by Leonardo Zimmerman on 17/02/2021.
//  Copyright © 2021 Leonardo Zimmerman. All rights reserved.
//

import UIKit

class DataProvider {
    class func fetchRestaurantData(completion: @escaping (Restaurant?)->()) {
        let path = "https://ptitchevreuil.github.io/test.json"
        guard let url = URL(string: path) else {
            completion(nil)
            return
        }
        DataTaskFactory.decodableDataTask(with: url, completion: completion).resume()
    }

    class func getImage(urlString: String, completion: @escaping (UIImage?)->()) {
        let imageName = String(urlString.suffix(10))
        if let imageFromStorage = StorageManager.loadImage(withName: imageName){
            completion(imageFromStorage)
        } else {
            guard let url = URL(string: urlString) else { return }
            DataTaskFactory.imageDataTask(with: url) { (image) in
                if let image = image {
                    StorageManager.saveImage(image, name: imageName)
                }
                completion(image)
            }.resume()
        }
    }
}
