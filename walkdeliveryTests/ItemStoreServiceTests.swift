//
//  ItemStoreServiceTests.swift
//  walkdelivery
//
//  Created by AndreyLebedev on 28/05/2017.
//  Copyright © 2017 lebedac. All rights reserved.
//

@testable import walkdelivery

import XCTest

class ItemStoreServiceTests: XCTestCase {
	
	var itemsStoreService = ItemsStoreService()
    
    override func setUp() {
        super.setUp()
		
    }
    
    override func tearDown() {
		
        super.tearDown()
    }
	
	func testUpdateItems() {
		let items = [
			ItemEntity(uid: "", name: "Cheese", description: "The best cheese", imageURLString: "imageURL1"),
			ItemEntity(uid: "", name: "Onion", description: "The best onion", imageURLString: "imageURL2"),
			ItemEntity(uid: "", name: "Orange juice", description: "The best juice", imageURLString: "imageURL3")
		]
		
		var sendingSucceed = false
		let expectation = self.expectation(description: "wait for sending items")
		itemsStoreService.update(items: items) { result in
			
			switch result {
			case .Success():
				sendingSucceed = true
			default: break
			}
			expectation.fulfill()
		}
		wait(for: [expectation], timeout: 10.0)
		
		XCTAssertTrue(sendingSucceed, "Error after sending")
		
	}
	
	func testGetItemsFromStoreService() {
		
		var items = [ItemEntity]()
		
		let expectation = self.expectation(description: "wait for getting items")
		itemsStoreService.getItems(request: ItemsRequest()) { result in
			
			switch result {
			case .Success(let remoteItems):
				items = remoteItems
			default: break
			}
			
			expectation.fulfill()
		}
		wait(for: [expectation], timeout: 10.0)
		
		XCTAssertTrue(items.count > 0, "Items are not got")
	}
}
