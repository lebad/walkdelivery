//
//  InitialFlowItemsInteractorTests.swift
//  walkdelivery
//
//  Created by AndreyLebedev on 18/05/2017.
//  Copyright © 2017 lebedac. All rights reserved.
//

@testable import walkdelivery

import XCTest

class InitialFlowItemsInteractorOutputMock: InitialFlowItemsInteractorOutput {
	
	var items = [ItemEntity]()
	var errorMessage: ErrorEntity?
	var showAuthCalled = false
	
	func present(items: [ItemEntity]) {
		self.items = items
	}
	
	func present(errorMessage: ErrorEntity) {
		self.errorMessage = errorMessage
	}
	
	func presentAuth() {
		showAuthCalled = true
	}
}

class ItemsStoreServiceFake: ItemsStoreServiceProtocol {
	
	var isFailure = false
	
	func getItems(request: ItemsRequest, completionHandler: @escaping (ItemsResult<[ItemEntity]>) -> Void) {
		let item = ItemEntity(dict: [:])
		
		if isFailure {
			completionHandler(.Failure(.InnerError))
			return
		}
		completionHandler(.Success([item]))
	}
	
	func update(items:[ItemEntity], completionHandler: @escaping (ItemsResult<Void>) -> Void) {
		
	}
}

class AuthServiceFake: AuthServiceProtocol {
	
	var hasAuth = true
	var error: ErrorEntity?
	
	func checkAuth(completionHandler: @escaping (AuthResult) -> Void) {
		guard error == nil else {
			completionHandler(.Failure(.InnerError))
			return
		}
		
		if hasAuth {
			completionHandler(.Success(UserEntity()))
			return
		}
		completionHandler(.NotRegistered)
	}
	
	func requestAuth(request: RequestUser, completionHandler: @escaping (AuthResult) -> Void) {
		
	}
}

class InitialFlowItemsInteractorTests: XCTestCase {
	
	var interactor: InitialFlowItemsInteractor!
	var interactorOutput: InitialFlowItemsInteractorOutputMock!
	var itemsStoreService: ItemsStoreServiceFake!
	var authService: AuthServiceFake!
    
    override func setUp() {
        super.setUp()
		
		interactor = InitialFlowItemsInteractor()
		interactorOutput = InitialFlowItemsInteractorOutputMock()
		itemsStoreService = ItemsStoreServiceFake()
		authService = AuthServiceFake()
		
		interactor.output = interactorOutput
		interactor.itemsStoreService = itemsStoreService
		interactor.authService = authService
    }
    
    override func tearDown() {
		interactor = nil
        super.tearDown()
    }
    
    func testRequestItemsToPresent() {
		interactor.requestItems()
		
		XCTAssertTrue(interactorOutput.items.count > 0, "Items didn't receive")
		XCTAssertFalse(interactorOutput.showAuthCalled, "showAuth should not be called")
    }
	
	func testRequestItemsToPresentError() {
		itemsStoreService.isFailure = true
		
		interactor.requestItems()
		
		XCTAssertNotNil(interactorOutput.errorMessage, "Error didn't receive")
	}
	
	func testRequestItemsToPresentAuth() {
		authService.hasAuth = false
		
		interactor.requestItems()
		
		XCTAssertTrue(interactorOutput.items.count == 0, "Items should not be received")
		XCTAssertTrue(interactorOutput.showAuthCalled, "showAuth didn't call")
	}
	
	func testRequestItemsToPresentAuthAfterGotError() {
		authService.error = ErrorEntity()
		
		interactor.requestItems()
		
		XCTAssertTrue(interactorOutput.items.count == 0, "Items should not be received")
		XCTAssertTrue(interactorOutput.showAuthCalled, "showAuth didn't call")
	}
}
