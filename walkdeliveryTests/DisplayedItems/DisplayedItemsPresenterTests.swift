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
	var showItemsCalled = false
	var items = [DisplayedItemViewModel]()
	var showErrorStringCalled = false
	var errorString = String()
	
	func setupViews() {
		setupViewsCalled = true
	}
	
	func show(items: [DisplayedItemViewModel]) {
		showItemsCalled = true
		self.items = items
	}
	
	func show(errorString: String) {
		showErrorStringCalled = true
		self.errorString = errorString
	}
}

class DisplayedItemsInteractorMock: DisplayedItemsInteractorInput {
	
	var requestItemsCalled = false
	
	func requestItems() {
		requestItemsCalled = true
	}
}

class ProgressTaskMock: TaskProgressShowable {
	
	var showStartCalled = false
	var showFinishCalled = false
	
	func showStart() {
		showStartCalled = true
	}
	
	func showFinish() {
		showFinishCalled = true
	}
}

class DisplayedItemsPresenterTests: XCTestCase {
	
	var presenter: DisplayedItemsPresenter!
	var view: DisplayedItemsViewMock!
	var interactor: DisplayedItemsInteractorMock!
	var progressTask: ProgressTaskMock!
	
	let testItems = [
		ItemEntity(uid: "uid1", name: "item1", description: "descr1", imageURLString: "imageurl1"),
		ItemEntity(uid: "uid2", name: "item2", description: "descr2", imageURLString: "imageurl2"),
		ItemEntity(uid: "uid3", name: "item3", description: "descr3", imageURLString: "imageurl3")
	]
    
    override func setUp() {
        super.setUp()
        presenter = DisplayedItemsPresenter()
		
		view = DisplayedItemsViewMock()
		interactor = DisplayedItemsInteractorMock()
		progressTask = ProgressTaskMock()
		
		presenter.view = view
		presenter.interactor = interactor
		presenter.progressTaskObject = progressTask
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
		
		XCTAssertTrue(progressTask.showStartCalled)
	}
	
	func testShowDownloadingFinishAfterPresentItemsOrPresentError() {
		presenter.present(items: testItems)
		
		XCTAssertTrue(progressTask.showFinishCalled)
	}
	
	func testShowDownloadingFinishAfterPresentError () {
		presenter.present(error: ErrorEntity(description: ""))
		
		XCTAssertTrue(progressTask.showFinishCalled)
	}
	
	func testReturnNumberOfRowsNotEqualZero() {
		presenter.present(items: testItems)
		
		let rows = presenter.numberOfRows()
		
		XCTAssertTrue(rows == testItems.count)
	}
	
	func testShowItemsAfterPresentItems() {
		let items = testItems
		
		presenter.present(items: items)
		
		XCTAssertTrue(view.showItemsCalled)
		XCTAssertTrue(view.items.count > 0)
		
		guard view.items.count > 0 else { return }
		
		for (index, item) in items.enumerated() {
			let nextIndex = index + 1 //because of separator
			XCTAssertEqual(item.uid, view.items[nextIndex].uid)
			XCTAssertEqual(item.name, view.items[nextIndex].name)
			XCTAssertEqual(item.description, view.items[nextIndex].description)
			XCTAssertEqual(item.imageURLString, view.items[nextIndex].imageURLString)
		}
	}
	
	func testShowErrorAfterPresentEmptyItems() {
		let items = [ItemEntity]()
		let errorString = "Error occured"
		
		presenter.present(items: items)
		
		XCTAssertFalse(view.showItemsCalled)
		XCTAssertTrue(view.showErrorStringCalled)
		XCTAssertEqual(view.errorString, errorString)
	}
	
	func testShowErrorAfterPresentError() {
		let errorEntity = ErrorEntity(description: "Error entity string")
		
		presenter.present(error: errorEntity)
		
		XCTAssertTrue(view.showErrorStringCalled)
		XCTAssertEqual(view.errorString, errorEntity.description)
	}
	
	func testViewModelAtIndex() {
		presenter.present(items: testItems)
		
		for (index, item) in view.items.enumerated() {
			XCTAssertEqual(item, presenter.viewModel(index) as! DisplayedItemViewModel)
		}
	}
}
