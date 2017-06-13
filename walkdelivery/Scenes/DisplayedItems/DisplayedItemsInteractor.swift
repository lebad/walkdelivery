//
//  DisplayedItemsInteractor.swift
//  walkdelivery
//
//  Created by AndreyLebedev on 10/06/2017.
//  Copyright © 2017 lebedac. All rights reserved.
//

import Foundation

class DisplayedItemsInteractor {
	
	weak var output: DisplayedItemsInteractorOutput?
	var itemsStoreService: ItemsStoreServiceProtocol?
}

extension DisplayedItemsInteractor: DisplayedItemsInteractorInput {
	
	func requestItems() {
		let request = ItemsRequest()
		itemsStoreService?.getItems(request: request) { [weak self] result in
			switch result {
			case .Success(let remoteItems):
				self?.output?.present(items: remoteItems)
			case .Failure( _):
				break
			}
		}
	}
}
