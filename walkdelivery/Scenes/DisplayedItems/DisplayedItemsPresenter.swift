//
//  DisplayedItemsPresenter.swift
//  walkdelivery
//
//  Created by AndreyLebedev on 18/05/2017.
//  Copyright © 2017 lebedac. All rights reserved.
//

import Foundation

class DisplayedItemsPresenter {
	
	weak var view: DisplayedItemsViewInput?
	var interactor: DisplayedItemsInteractorInput?
	weak var progressTaskObject: TaskProgressShowable?
}

extension DisplayedItemsPresenter: DisplayedItemsInteractorOutput {
	
	func present(items: [ItemEntity]) {
		
		guard items.count > 0 else {
			view?.show(errorString: "Error occured")
			return
		}
		
		var viewModelItems = [DisplayedItemViewModel]()
		for itemEntity in items {
			let itemViewModel = DisplayedItemViewModel(itemEntity: itemEntity)
			viewModelItems.append(itemViewModel)
		}
		view?.show(items: viewModelItems)
	}
	
	func present(error: ErrorEntity) {
		view?.show(errorString: error.description)
	}
}

extension DisplayedItemsPresenter: DisplayedItemsViewOutput {
	
	func viewPrepared() {
		interactor?.requestItems()
		view?.setupViews()
		progressTaskObject?.showStart()
	}
	
	func numberOfRows() -> Int {
		return 1
	}
}
