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
	var items = [ViewModelCellRepresentable]()
	var showErrorStringCalled = false
	var errorString = String()
	var header: DisplayedItemsHeaderViewModel?
	
	func setupViews() {
		setupViewsCalled = true
	}
	
	func show(items: [ViewModelCellRepresentable]) {
		showItemsCalled = true
		self.items = items
	}
	
	func show(header: DisplayedItemsHeaderViewModel) {
		self.header = header
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
		
		var displayedItems = [DisplayedItemViewModel]()
		
		for (index, model) in view.items.enumerated() {
			if index % 2 == 0 { //even is separator
				XCTAssertTrue(model is DisplayedItemSeparatorViewModel)
			} else {
				XCTAssertTrue(model is DisplayedItemViewModel)
				displayedItems.append(model as! DisplayedItemViewModel)
			}
		}
		
		for (index, item) in items.enumerated() {
			XCTAssertEqual(item.uid, displayedItems[index].uid)
			XCTAssertEqual(item.name, displayedItems[index].name)
			XCTAssertEqual(item.description, displayedItems[index].description)
			XCTAssertEqual(item.imageURLString, displayedItems[index].imageURLString)
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
	
	func testShowHeaderAfterViewPrepared() {
		let validHeader = DisplayedItemsHeaderViewModel(title: "Walk Delivery")
		
		presenter.viewPrepared()
		
		XCTAssertEqual(view.header, validHeader)
	}
}
