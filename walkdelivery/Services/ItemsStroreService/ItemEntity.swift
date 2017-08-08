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
	var price: MoneyEntity
}

extension ItemEntity: DictionaryConvertable {
	
	init(dict: [String: Any]) {
		let uid = dict["uid"] as? String ?? ""
		let name = dict["name"] as? String ?? ""
		let description = dict["description"] as? String ?? ""
		let imageURLString = dict["image_url_string"] as? String ?? ""
		let priceDict = dict["price"] as? [String: String] ?? [:]
		let price = MoneyEntity(dict: priceDict)
		self.init(uid: uid, name: name, description: description, imageURLString: imageURLString, price: price)
	}
	
	func convertToDict() -> [String: Any] {
		let priceDict = ["amount": price.amount.stringValue,
						 "currencyCode": price.currency.code
						]
		let dict = ["name": name,
		            "description": description,
		            "image_url_string": imageURLString,
					"price": priceDict
				    ] as [String: Any]
		return dict
	}
}

extension ItemEntity: Equatable {
	static func ==(lhs: ItemEntity, rhs: ItemEntity) -> Bool {
		return lhs.uid == rhs.uid &&
		lhs.name == rhs.name &&
		lhs.description == rhs.description &&
		lhs.imageURLString == rhs.imageURLString
	}
}
