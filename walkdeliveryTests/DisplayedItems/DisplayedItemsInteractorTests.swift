//
//  DisplayedItemsInteractorTests.swift
//  walkdeliveryTests
//
//  Created by AndreyLebedev on 13/06/2017.
//  Copyright © 2017 lebedac. All rights reserved.
//

@testable import walkdelivery
import XCTest

class DisplayedItemsPresenterMock: DisplayedItemsInteractorOutput {
	
	var items = [ItemEntity]()
	var error: ErrorEntity?
	
	func present(items: [ItemEntity]) {
		self.items = items
	}
	
	func present(error: ErrorEntity) {
		self.error = error
	}
}

class StoreServiceMock: ItemsStoreServiceProtocol {
	
	var items: [ItemEntity]?
	
	func getItems(request: ItemsRequest, completionHandler: @escaping (ItemsResult<[ItemEntity]>) -> Void) {
		guard let items = self.items, items.count > 0 else {
			completionHandler(.Failure(.InnerError))
			return
		}
		completionHandler(.Success(items))
	}
	
	func update(items:[ItemEntity], completionHandler: @escaping (ItemsResult<Void>) -> Void) {
		
	}
}

class DisplayedItemsInteractorTests: XCTestCase {
	
	var interactor: DisplayedItemsInteractor!
	var presenter: DisplayedItemsPresenterMock!
	var storeService: StoreServiceMock!
    
    override func setUp() {
        super.setUp()
		interactor = DisplayedItemsInteractor()
		presenter = DisplayedItemsPresenterMock()
		storeService = StoreServiceMock()
		
		interactor.output = presenter
		interactor.itemsStoreService = storeService
    }
    
    override func tearDown() {
		interactor = nil
        super.tearDown()
    }
	
	func testRequestItemsToCallPresentItems() {
		let items = [
					 ItemEntity(uid: "uid1", name: "item1", description: "descr1", imageURLString: "imageurl1"),
					 ItemEntity(uid: "uid2", name: "item2", description: "descr2", imageURLString: "imageurl2"),
					 ItemEntity(uid: "uid3", name: "item3", description: "descr3", imageURLString: "imageurl3")
					 ]
		storeService.items = items
		
		interactor.requestItems()
		
		XCTAssertTrue(presenter.items.count > 0)
		XCTAssertEqual(presenter.items, items)
	}
	
	func testRequestItemsToCallPresentError() {
		let error = ErrorEntity(description: "")
		
		interactor.requestItems()
		
		XCTAssertTrue(presenter.items.count == 0)
		XCTAssertEqual(presenter.error, error)
	}
}
