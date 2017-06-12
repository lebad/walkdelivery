//
//  DisplayedItemsPresenterTests.swift
//  walkdeliveryTests
//
//  Created by AndreyLebedev on 12/06/2017.
//  Copyright © 2017 lebedac. All rights reserved.
//

@testable import walkdelivery
import XCTest

class DisplayedItemsViewMock: DisplayedItemsViewInput {
	
	var setupViewsCalled = false
	var showDownloadingStartedCalled = false
	
	func setupViews() {
		setupViewsCalled = true
	}
	
	func showDownloadingStarted() {
		showDownloadingStartedCalled = true
	}
}

class DisplayedItemsInteractorMock: DisplayedItemsInteractorInput {
	
	var requestItemsCalled = false
	
	func requestItems() {
		requestItemsCalled = true
	}
}

class DisplayedItemsPresenterTests: XCTestCase {
	
	var presenter: DisplayedItemsPresenter!
	var view: DisplayedItemsViewMock!
	var interactor: DisplayedItemsInteractorMock!
    
    override func setUp() {
        super.setUp()
        presenter = DisplayedItemsPresenter()
		
		view = DisplayedItemsViewMock()
		interactor = DisplayedItemsInteractorMock()
		
		presenter.view = view
		presenter.interactor = interactor
    }
    
    override func tearDown() {
        presenter = nil
        super.tearDown()
    }
	
	func testSetupViewsAfterViewPrepared() {
		presenter.viewPrepared()
		
		XCTAssertTrue(view.setupViewsCalled)
	}
	
	func testRequestItemsAfterViewPrepared() {
		presenter.viewPrepared()
		
		XCTAssertTrue(interactor.requestItemsCalled)
	}
	
	func testShowDownloadingStartedAfterViewPrepared() {
		presenter.viewPrepared()
		
		XCTAssertTrue(view.showDownloadingStartedCalled)
	}
	
	func testReturnNumberOfRowsNotEqualZero() {
		let rows = presenter.numberOfRows()
		
		XCTAssertTrue(rows > 0)
	}
}
