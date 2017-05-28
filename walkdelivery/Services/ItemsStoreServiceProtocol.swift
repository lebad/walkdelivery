//
//  ItemsStoreServiceProtocol.swift
//  walkdelivery
//
//  Created by AndreyLebedev on 18/05/2017.
//  Copyright © 2017 lebedac. All rights reserved.
//

import Foundation

struct ItemEntity {
	var uid: String
	var name: String
	var description: String
	var imageURLString: String
}

extension ItemEntity {
	init(dict: [String: Any]) {
		let uid = dict["uid"] as? String ?? ""
		let name = dict["name"] as? String ?? ""
		let description = dict["description"] as? String ?? ""
		let imageURLString = dict["image_url_string"] as? String ?? ""
		self.init(uid: uid, name: name, description: description, imageURLString: imageURLString)
	}
}

struct ItemsRequest {
	
}

enum ItemsResult {
	case Success([ItemEntity])
	case Failure(ItemsStoreError)
}

enum ItemsStoreError: Error {
	case InnerError
}

protocol ItemsStoreServiceProtocol: class {
	
	func getItems(request: ItemsRequest, completionHandler: @escaping (ItemsResult) -> Void)
}
