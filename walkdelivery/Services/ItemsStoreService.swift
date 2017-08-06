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
	
	var fireBaseReference = FIRDatabase.database().reference()
	
	func getItems(request: ItemsRequest, completionHandler: @escaping (ItemsResult<[ItemEntity]>) -> Void) {
		
		fireBaseReference.child("items").observeSingleEvent(of: .value, with: { snapshot in
			
			guard snapshot.hasChildren() == true, let snaps = snapshot.children.allObjects as? [FIRDataSnapshot] else {
				completionHandler(.Failure(.InnerError))
				return
			}
			
			var itemsToReturn = [ItemEntity]()
			for snap in snaps {
				if var snapshotValue = snap.value as? [String: Any] {
					snapshotValue["uid"] = snap.key
					let itemEntity = ItemEntity(dict: snapshotValue)
					itemsToReturn.append(itemEntity)
				}
			}
			completionHandler(.Success(itemsToReturn))
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
