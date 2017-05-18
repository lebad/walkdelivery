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
	func receive(items: [ItemEntity])
}

class ChooseItemInteractor: ChooseItemInteractorInput {
	
	weak var output: ChooseItemInteractorOutput?
	var itemsStoreService: ItemsStoreServiceProtocol?
	
	func requestItems() {
		let request = ItemsRequest()
		
		itemsStoreService?.getItems(request: request) { [weak self] result in
			
			switch result {
			case .Success(let items):
				self?.output?.receive(items: items)
			case .Failure(let error):
				print("\(error)")
			}
		}
	}
}
