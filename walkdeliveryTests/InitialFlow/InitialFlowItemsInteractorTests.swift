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
	
	var errorMessage: ErrorEntity?
	var presentAuthCalled = false
	var presentDisplayedItemsScreenCalled = false
	
	func presentDisplayedItemsScreen() {
		presentDisplayedItemsScreenCalled = true
	}
	
	func present(errorMessage: ErrorEntity) {
		self.errorMessage = errorMessage
	}
	
	func presentAuth() {
		presentAuthCalled = true
	}
}

class AuthServiceFake: AuthServiceProtocol {
	
	var hasAuth = true
	var hasError = false
	var authStateChanged = false {
		didSet {
			self.listenerCompletionHandler?(.NotRegistered)
		}
	}
	
	var listenAuthStateCalled = false
	
	var listenerCompletionHandler: ((AuthResult) -> Void)?
	
	func checkAuth(completionHandler: @escaping (AuthResult) -> Void) {
		guard hasError == false else {
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
	
	func listenAuthState(completionHandler: @escaping (AuthResult) -> Void) {
		listenAuthStateCalled = true
		listenerCompletionHandler = completionHandler
	}
}

class InitialFlowItemsInteractorTests: XCTestCase {
	
	var interactor: InitialFlowItemsInteractor!
	var interactorOutput: InitialFlowItemsInteractorOutputMock!
	var authService: AuthServiceFake!
    
    override func setUp() {
        super.setUp()
		
		interactor = InitialFlowItemsInteractor()
		interactorOutput = InitialFlowItemsInteractorOutputMock()
		authService = AuthServiceFake()
		
		interactor.output = interactorOutput
		interactor.authService = authService
    }
    
    override func tearDown() {
		interactor = nil
        super.tearDown()
    }
    
    func testStartFlowToPresentItemsScreenIfHasAuth() {
		interactor.startFlow()
		
		XCTAssertFalse(interactorOutput.presentAuthCalled, "presentAuth should not be called")
		XCTAssertTrue(interactorOutput.presentDisplayedItemsScreenCalled, "presentDisplayedItemsScreen didn't call")
		XCTAssertTrue(authService.listenAuthStateCalled)
    }
	
	func testStartFlowToPresentAuthIfNotHasAuth() {
		authService.hasAuth = false
		
		interactor.startFlow()
		
		XCTAssertTrue(interactorOutput.presentAuthCalled)
	}
	
	func testStartFlowToPresentError() {
		authService.hasError = true
		let errorEntity = ErrorEntity(description: "Authorization Error")
		
		interactor.startFlow()
		
		XCTAssertEqual(interactorOutput.errorMessage, errorEntity)
	}
	
	func testPresentAuthAfterAuthStateChangedAndUserNotRegistered() {
		interactor.startFlow()
		
		authService.authStateChanged = true
		
		XCTAssertTrue(interactorOutput.presentAuthCalled)
	}
}
