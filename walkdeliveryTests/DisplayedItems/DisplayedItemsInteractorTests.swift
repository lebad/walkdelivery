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
