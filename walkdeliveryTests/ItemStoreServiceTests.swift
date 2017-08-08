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
	
	var itemsStoreService = ItemsStoreService(moneyService: MoneyService())
    
    override func setUp() {
        super.setUp()
		
    }
    
    override func tearDown() {
		
        super.tearDown()
    }
	
	func testUpdateItems() {
		let items = [
			ItemEntity(uid: "",
			           name: "Cheese",
			           description: "The best cheese",
			           imageURLString: "https://firebasestorage.googleapis.com/v0/b/walkdelivery.appspot.com/o/Emmentaler-w.jpg?alt=media&token=79279b1c-1cd3-4790-967c-c63fde6d1998",
				       price: MoneyEntity(amount: NSDecimalNumber(string: "12.00"),
				                          currency: CurrencyEntity(code: "USD", name: "Dollar", sign: "$"))),
			ItemEntity(uid: "",
			           name: "Onion",
			           description: "The best onion",
			           imageURLString: "https://firebasestorage.googleapis.com/v0/b/walkdelivery.appspot.com/o/fresh-yellow-onion.jpg?alt=media&token=3ca1350c-4261-4644-8c24-f9cd9ab927b3",
			           price: MoneyEntity(amount: NSDecimalNumber(string: "1.20"),
			                              currency: CurrencyEntity(code: "USD", name: "Dollar", sign: "$"))),
			ItemEntity(uid: "",
			           name: "Orange juice",
			           description: "The best juice",
			           imageURLString: "https://firebasestorage.googleapis.com/v0/b/walkdelivery.appspot.com/o/juice.jpg?alt=media&token=c2254eba-f900-4d9d-8e0e-d2e87a6b9e44",
			           price: MoneyEntity(amount: NSDecimalNumber(string: "0.40"),
			                              currency: CurrencyEntity(code: "USD", name: "Dollar", sign: "$")))
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
		waitForExpectations(timeout: 10.0)
		
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
		waitForExpectations(timeout: 10.0)
		
		XCTAssertTrue(items.count > 0, "Items are not got")
	}
}
