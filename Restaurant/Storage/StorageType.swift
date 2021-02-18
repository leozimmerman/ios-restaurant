//
//  StorageType.swift
//  Restaurant
//
//  Created by Leonardo Zimmerman on 17/02/2021.
//  Copyright © 2021 Leonardo Zimmerman. All rights reserved.
//

import Foundation

enum StorageType {
    case cache
    case permanent
    
    var searchPathDirectory: FileManager.SearchPathDirectory {
        switch self {
        case .cache: return .cachesDirectory
        case .permanent: return .documentDirectory
        }
    }
    
    var jsonFolder: URL {
        let subfolder = "com.Restaurant.json_storage"
        return rootFolder.appendingPathComponent(subfolder)
    }
    
    var rootFolder: URL {
        let path = NSSearchPathForDirectoriesInDomains(searchPathDirectory, .userDomainMask, true).first!
        return URL(fileURLWithPath: path)
    }
    
    func clearStorage() {
        try? FileManager.default.removeItem(at: rootFolder)
    }
}
