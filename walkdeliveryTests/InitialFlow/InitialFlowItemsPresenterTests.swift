//
//  InitialFlowItemsPresenterTests.swift
//  walkdelivery
//
//  Created by AndreyLebedev on 03/06/2017.
//  Copyright © 2017 lebedac. All rights reserved.
//

@testable import walkdelivery
import XCTest

class InitialFlowItemsRouterMock: InitialFlowItemsRouterInput {
	
	var routeToAuthSceneCalled = false
	var routeToDisplayedItemsSceneCalled = false
	
	func routeToAuthScene() {
		routeToAuthSceneCalled = true
	}
	
	func routeToDisplayedItemsScene() {
		routeToDisplayedItemsSceneCalled = true
	}
}

class InitialFlowItemsPresenterTests: XCTestCase {
	
	var presenter = InitialFlowItemsPresenter()
	var router: InitialFlowItemsRouterMock!
    
    override func setUp() {
        super.setUp()
		router = InitialFlowItemsRouterMock()
		presenter.router = router
    }
    
    override func tearDown() {
		router = nil
        super.tearDown()
    }
	
	func testRouteToDisplayItemsSceneAfterPresentItems() {
		let itemEntity = ItemEntity(dict: [:])
		presenter.present(items: [itemEntity])
		
		XCTAssertTrue(router.routeToDisplayedItemsSceneCalled, "Displayed items didn't call")
	}
	
	func testRouteToDisplayItemsSceneAfterPresentError() {
		presenter.present(errorMessage: ErrorEntity())
		
		XCTAssertTrue(router.routeToDisplayedItemsSceneCalled, "Displayed items didn't call")
	}
	
	func testRouteToAuthSceneAfterPresentAuth() {
		presenter.presentAuth()
		
		XCTAssertTrue(router.routeToAuthSceneCalled, "AuthScene didn't call")
	}
}
