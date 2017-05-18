//
//  ChooseItemInteractorTests.swift
//  walkdelivery
//
//  Created by AndreyLebedev on 18/05/2017.
//  Copyright © 2017 lebedac. All rights reserved.
//

@testable import walkdelivery

import XCTest

class ChooseItemInteractorOutputMock: ChooseItemInteractorOutput {
	
	var items = [ItemEntity]()
	
	func receive(items: [ItemEntity]) {
		self.items = items
	}
}

class ItemsStoreServiceFake: ItemsStoreServiceProtocol {
	
	func getItems(request: ItemsRequest, completionHandler: @escaping (ItemsResult) -> Void) {
		let items = [ItemEntity()]
		completionHandler(.Success(items))
	}
}

class ChooseItemInteractorTests: XCTestCase {
	
	var interactor: ChooseItemInteractor!
	var interactorOutput: ChooseItemInteractorOutputMock!
	var itemsStoreService: ItemsStoreServiceFake!
    
    override func setUp() {
        super.setUp()
		
		interactor = ChooseItemInteractor()
		interactorOutput = ChooseItemInteractorOutputMock()
		itemsStoreService = ItemsStoreServiceFake()
		
		interactor.output = interactorOutput
		interactor.itemsStoreService = itemsStoreService
    }
    
    override func tearDown() {
		
        super.tearDown()
    }
    
    func testRequestItemsToReceive() {
		interactor.requestItems()
		
		let items = interactorOutput.items
		
		XCTAssertTrue(items.count > 0, "Items didn't receive")
    }
}
