//
//  ItemsStoreServiceProtocol.swift
//  walkdelivery
//
//  Created by AndreyLebedev on 18/05/2017.
//  Copyright © 2017 lebedac. All rights reserved.
//

import Foundation

struct ItemEntity {
	
}

struct ItemsRequest {
	
}

enum ItemsResult {
	case Success([ItemEntity])
	case Failure(Error?)
}

protocol ItemsStoreServiceProtocol: class {
	
	func getItems(request: ItemsRequest, completionHandler: @escaping (ItemsResult) -> Void)
}
