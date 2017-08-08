 //
//  ItemsStoreService.swift
//  walkdelivery
//
//  Created by AndreyLebedev on 18/05/2017.
//  Copyright © 2017 lebedac. All rights reserved.
//

import Foundation
import FirebaseDatabase


class ItemsStoreService: ItemsStoreServiceProtocol {
	
	private var moneyService: MoneyServiceProtocol
	private var fireBaseReference = FIRDatabase.database().reference()
	
	init(moneyService: MoneyServiceProtocol) {
		self.moneyService = moneyService
	}
	
	func getItems(request: ItemsRequest, completionHandler: @escaping (ItemsResult<[ItemEntity]>) -> Void) {
		
		fireBaseReference.child("items").observeSingleEvent(of: .value, with: { snapshot in
			
			guard snapshot.hasChildren() == true, let snaps = snapshot.children.allObjects as? [FIRDataSnapshot] else {
				completionHandler(.Failure(.InnerError))
				return
			}
			
			var storedCurrencyError: CurrencyError?
			
			let dispatchGroup = DispatchGroup()
			
			var itemsToReturn = [ItemEntity]()
			for snap in snaps {
				
				
				if var snapshotValue = snap.value as? [String: Any] {
					if let price = snapshotValue["price"] as? [String: String], let codeString = price["currencyCode"] {
						
						dispatchGroup.enter()
						
						self.moneyService.getCurrency(codeString) { result in
							
							snapshotValue["uid"] = snap.key
							var itemEntity = ItemEntity(dict: snapshotValue)
							var moneyEnity = MoneyEntity(dict: price)
							
							switch result {
							case .Success(let currency):
								moneyEnity.currency = currency
								itemEntity.price = moneyEnity
								itemsToReturn.append(itemEntity)
							case .Failure(let error):
								storedCurrencyError = error
							}
							dispatchGroup.leave()
						}
					}
				}
			}
			dispatchGroup.notify(queue: DispatchQueue.main) {
				guard storedCurrencyError == nil else {
					completionHandler(.Failure(.InnerError))
					return
				}
				completionHandler(.Success(itemsToReturn))
			}
		})
	}
	
	func update(items:[ItemEntity], completionHandler: @escaping (ItemsResult<Void>) -> Void) {
		
		var storedError: Error?
		
		let dispatchGroup = DispatchGroup()
		for item in items {
			let itemDict = item.convertToDict()
			
			dispatchGroup.enter()
			fireBaseReference.child("items").childByAutoId().setValue(itemDict) { error, fireBaseReference in
				
				if error != nil {
					storedError = error
				}
				dispatchGroup.leave()
			}
		}
		dispatchGroup.notify(queue: DispatchQueue.main) {
			guard storedError == nil else {
				completionHandler(.Failure(.InnerError))
				return
			}
			completionHandler(.Success())
		}
	}
}
