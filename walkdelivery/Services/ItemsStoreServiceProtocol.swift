//
//  ItemsStoreServiceProtocol.swift
//  walkdelivery
//
//  Created by AndreyLebedev on 18/05/2017.
//  Copyright © 2017 lebedac. All rights reserved.
//

import Foundation

public struct ItemEntity {
	
}

public struct ItemsRequest {
	
}

public enum ItemsResult {
	case Success([ItemEntity])
	case Failure(Error?)
}

public protocol ItemsStoreServiceProtocol: class {
	
	func getItems(request: ItemsRequest, completionHandler: @escaping (ItemsResult) -> Void)
}
