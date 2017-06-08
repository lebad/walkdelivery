//
//  InitialFlowItemsInteractor.swift
//  walkdelivery
//
//  Created by AndreyLebedev on 18/05/2017.
//  Copyright © 2017 lebedac. All rights reserved.
//

import Foundation

class InitialFlowItemsInteractor: InitialFlowItemsInteractorInput {
	
	var output: InitialFlowItemsInteractorOutput?
	var itemsStoreService: ItemsStoreServiceProtocol?
	var authService: AuthServiceProtocol?
	var itemsObserver: ItemsDownloadNotifiable?
	
	func requestItems() {
		
		authService?.checkAuth { result in
			
			switch result {
			case .Success( _):
				self.output?.presentItemsScreen()
				self.requestItemsForService()
			case .NotRegistered:
				self.output?.presentAuth()
			case .Failure( _):
				self.output?.presentAuth()
			default: break
			}
		}
	}
	
	func listenAuthChanges() {
		authService?.listenAuthState{ result in
			switch result {
			case.NotRegistered:
				self.output?.presentAuth()
			default: break
			}
		}
	}
	
	private func requestItemsForService() {
		let request = ItemsRequest()
		itemsStoreService?.getItems(request: request) { [weak self] result in
			
			switch result {
			case .Success(let items):
				self?.itemsObserver?.didDownload(items: items)
			case .Failure(let error):
				self?.output?.present(errorMessage: ErrorEntity(description: "\(String(describing: error))"))
			}
		}
	}
}
