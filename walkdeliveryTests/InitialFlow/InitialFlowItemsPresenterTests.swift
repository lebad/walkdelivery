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

class ItemsDownloadNotifiableMock: ItemsDownloadNotifiable {
	
	var didDownloadItemsCalled = false
	
	func didDownload(items: [ItemEntity]) {
		didDownloadItemsCalled = true
	}
}

class InitialFlowItemsPresenterTests: XCTestCase {
	
	var presenter = InitialFlowItemsPresenter()
	var router: InitialFlowItemsRouterMock!
	var observer: ItemsDownloadNotifiableMock!
    
    override func setUp() {
        super.setUp()
		router = InitialFlowItemsRouterMock()
		presenter.router = router
		
		observer = ItemsDownloadNotifiableMock()
		presenter.itemsObserver = observer
    }
    
    override func tearDown() {
		router = nil
        super.tearDown()
    }
	
	func testNotifyDownloadItemsAfterPresentItems() {
		let itemEntity = ItemEntity(dict: [:])
		presenter.present(items: [itemEntity])
		
		XCTAssertTrue(observer.didDownloadItemsCalled, "didDownloadItems didn't call")
	}
	
	func testRouteToDisplayItemsSceneAfterPresentItemsScreen() {
		presenter.presentItemsScreen()
		
		XCTAssertTrue(router.routeToDisplayedItemsSceneCalled, "Displayed items didn't call")
	}
	
	func testRouteToDisplayItemsSceneAfterPresentError() {
		presenter.present(errorMessage: ErrorEntity(description: ""))
		
		XCTAssertTrue(router.routeToDisplayedItemsSceneCalled, "Displayed items didn't call")
	}
	
	func testRouteToAuthSceneAfterPresentAuth() {
		presenter.presentAuth()
		
		XCTAssertTrue(router.routeToAuthSceneCalled, "AuthScene didn't call")
	}
}
