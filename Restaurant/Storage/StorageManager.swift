//
//  StorageManager.swift
//  Restaurant
//
//  Created by Leonardo Zimmerman on 17/02/2021.
//  Copyright © 2021 Leonardo Zimmerman. All rights reserved.
//

import UIKit

class StorageManager {
    class func saveImage(_ image: UIImage, name: String) {
        let pathURL: URL =  StorageType.permanent.rootFolder.appendingPathComponent(name)
        do {
            try image.jpegData(compressionQuality: 1)?.write(to: pathURL)
        } catch let error {
            print("StorageManager: Error saving image (\(error)")
        }
    }
    
    class func loadImage(withName name: String) -> UIImage? {
        let fileUrlPath = StorageType.permanent.rootFolder.appendingPathComponent(name).path
        return UIImage(contentsOfFile: fileUrlPath)
    }
}
