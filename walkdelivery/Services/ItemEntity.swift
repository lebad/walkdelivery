//
//  ItemEntity.swift
//  walkdelivery
//
//  Created by AndreyLebedev on 02/06/2017.
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
	
	func convertToDict() -> [String: Any] {
		let dict = ["name": name,
		            "description": description,
		            "image_url_string": imageURLString]
		return dict
	}
}
