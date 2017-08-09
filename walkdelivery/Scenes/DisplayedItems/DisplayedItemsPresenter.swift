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
	var router: DisplayedItemScreenRouterInput?
	weak var progressTaskObject: TaskProgressShowable?
	
	var itemEntities = [ItemEntity]()
	var viewModelItems = [ViewModelCellRepresentable]()
}

extension DisplayedItemsPresenter: DisplayedItemsInteractorOutput {
	
	func present(items: [ItemEntity]) {
		
		itemEntities = items
		
		guard items.count > 0 else {
			view?.show(errorString: "Error occured")
			return
		}
		
		let separator = DisplayedItemSeparatorViewModel()
		for itemEntity in items {
			self.viewModelItems.append(separator)

			let itemViewModel = DisplayedItemViewModel(itemEntity: itemEntity)
			self.viewModelItems.append(itemViewModel)
		}
		self.viewModelItems.append(separator)
		
		progressTaskObject?.showFinish()
		view?.show(items: self.viewModelItems)
	}
	
	func present(error: ErrorEntity) {
		progressTaskObject?.showFinish()
		view?.show(errorString: error.description)
	}
}

extension DisplayedItemsPresenter: DisplayedItemsViewOutput {
	
	func viewPrepared() {
		interactor?.requestItems()
		view?.setupViews()
		view?.show(header: DisplayedItemsHeaderViewModel(title: "Walk Delivery"))
		progressTaskObject?.showStart()
	}
	
	func numberOfRows() -> Int {
		return viewModelItems.count
	}
	
	func viewModel(_ index: Int) -> ViewModelCellRepresentable {
		return viewModelItems[index]
	}
	
	func didSelectRow(_ index: Int) {
		let item = itemEntities[index]
		router?.routeToRequestingItem(item)
	}
}
