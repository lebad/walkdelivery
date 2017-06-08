//
//  InitialFlowItemsPresenter.swift
//  walkdelivery
//
//  Created by AndreyLebedev on 03/06/2017.
//  Copyright © 2017 lebedac. All rights reserved.
//

import Foundation

class InitialFlowItemsPresenter: InitialFlowItemsInteractorOutput {
	
	var router: InitialFlowItemsRouterInput?
	
	func present(items: [ItemEntity]) {
		itemsObserver?.didDownload(items: items)
	}
	
	func present(errorMessage: ErrorEntity) {
		router?.routeToDisplayedItemsScene()
	}
	
	func presentAuth() {
		router?.routeToAuthScene()
	}
	
	func presentItemsScreen() {
		router?.routeToDisplayedItemsScene()
	}
}
