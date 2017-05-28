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
	
	var fireBaseReference = FIRDatabase.database().reference(withPath: "items")
	
	func getItems(request: ItemsRequest, completionHandler: @escaping (ItemsResult) -> Void) {
		
		fireBaseReference.observeSingleEvent(of: .value, with: { snapshot in
			
			guard snapshot.exists() == true, let remoteItems = snapshot.value as? NSArray else {
				completionHandler(.Failure(.InnerError))
				return
			}
			
			var itemsToReturn = [ItemEntity]()
			for case let item as [String: Any] in remoteItems {
				let itemIntity = ItemEntity(dict: item)
				itemsToReturn.append(itemIntity)
			}
			completionHandler(.Success(itemsToReturn))
		})
	}
}
