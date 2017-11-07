//
//  ItemsStoreServiceProtocol.swift
//  walkdelivery
//
//  Created by AndreyLebedev on 18/05/2017.
//  Copyright © 2017 lebedac. All rights reserved.
//

import Foundation
import CoreLocation

struct ItemsRequest {
	let customerLocationCoordinate: CLLocationCoordinate2D
	let radius: Double
}

enum ItemsResult<U> {
	case Success(U)
	case Failure(ItemsStoreError)
}

enum ItemsStoreError: Error {
	case InnerError
}

protocol ItemsStoreServiceProtocol: class {
	func getItems(request: ItemsRequest, completionHandler: @escaping (ItemsResult<[ItemEntity]>) -> Void)
	func update(items:[ItemEntity], completionHandler: @escaping (ItemsResult<Void>) -> Void)
}
