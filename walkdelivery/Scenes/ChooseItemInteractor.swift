//
//  ChooseItemInteractor.swift
//  walkdelivery
//
//  Created by AndreyLebedev on 18/05/2017.
//  Copyright © 2017 lebedac. All rights reserved.
//

import Foundation

protocol ChooseItemInteractorInput: class {
	func requestItems()
}

protocol ChooseItemInteractorOutput: class {
	func present(items: [ItemEntity])
	func present(errorMessage: ErrorEntity)
	func presentAuth()
}

class ChooseItemInteractor: ChooseItemInteractorInput {
	
	weak var output: ChooseItemInteractorOutput?
	var itemsStoreService: ItemsStoreServiceProtocol?
	var authService: AuthServiceProtocol?
	
	func requestItems() {
		
		authService?.checkAuth { result in
			
			switch result {
			case .Success( _):
				self.requestItemsForService()
			case .NotRegistered:
				self.output?.presentAuth()
			case .Failure(let error):
				self.output?.presentAuth()
			}
		}
	}
	
	private func requestItemsForService() {
		let request = ItemsRequest()
		itemsStoreService?.getItems(request: request) { [weak self] result in
			
			switch result {
			case .Success(let items):
				self?.output?.present(items: items)
			case .Failure(let error):
				self?.output?.present(errorMessage: ErrorEntity(description: "\(String(describing: error))"))
			}
		}
	}
}
