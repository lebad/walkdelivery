//
//  InitialFlowItemsAssembly.swift
//  walkdelivery
//
//  Created by AndreyLebedev on 03/06/2017.
//  Copyright © 2017 lebedac. All rights reserved.
//

import Foundation

class InitialFlowItemsAssembly {
	
	static func configureInteractor() -> InitialFlowItemsInteractorInput {
		let presenter = InitialFlowItemsPresenter()
		let router = InitialFlowItemsRouter()
		presenter.router = router
		
		let interactor = InitialFlowItemsInteractor()
		interactor.output = presenter
		interactor.authService = AuthService()
		interactor.itemsStoreService = ItemsStoreService()
		
		return interactor
	}
}
