//
//  RestaurantTests.swift
//  RestaurantTests
//
//  Created by Leonardo Zimmerman on 17/02/2021.
//  Copyright © 2021 Leonardo Zimmerman. All rights reserved.
//

import XCTest
@testable import Restaurant

class RestaurantTest: XCTestCase {
    func testRestaurantDecoding() {
        
        let bundle = Bundle(for: type(of: self))
        let decoder = JSONDecoder()
        
        let fileUrl = bundle.url(forResource: "restaurant", withExtension: "json")
        let fileData = try! Data(contentsOf: fileUrl!)
        let restaurant = try? decoder.decode(Restaurant.self, from: fileData)
        
        XCTAssertEqual(restaurant?.id, 6861)
        XCTAssertEqual(restaurant?.zipcode, "75011")
        XCTAssertEqual(restaurant?.pictures.count, 6)
        XCTAssertEqual(restaurant?.cardPrice, 27)        
    }
    
    func testStorageManager() {
        let image = UIImage(named: "imageBlack")!
        let name = "testName"
        StorageManager.saveImage(image, name: name)
        
        let loadedImage = StorageManager.loadImage(withName: name)
        XCTAssertNotNil(loadedImage)
    }
}
