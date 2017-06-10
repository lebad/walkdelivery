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
	
	func presentDisplayedItemsScreen() {
		router?.routeToDisplayedItemsScene()
	}
	
	func present(errorMessage: ErrorEntity) {
		router?.routeToDisplayedItemsScene()
	}
	
	func presentAuth() {
		router?.routeToAuthScene()
	}
}
