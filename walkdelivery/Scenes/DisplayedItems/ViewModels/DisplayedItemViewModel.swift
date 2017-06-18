//
//  DisplayedItemViewModel.swift
//  walkdelivery
//
//  Created by AndreyLebedev on 15/06/2017.
//  Copyright © 2017 lebedac. All rights reserved.
//

import Foundation

struct DisplayedItemViewModel {
	var uid: String
	var name: String
	var description: String
	var imageURLString: String
}

extension DisplayedItemViewModel {
	init(itemEntity: ItemEntity) {
		uid = itemEntity.uid
		name = itemEntity.name
		description = itemEntity.description
		imageURLString = itemEntity.imageURLString
	}
}

extension DisplayedItemViewModel: Equatable {
	static func ==(lhs: DisplayedItemViewModel, rhs: DisplayedItemViewModel) -> Bool {
		return lhs.uid == rhs.uid &&
		lhs.name == rhs.name &&
		lhs.description == rhs.description &&
		lhs.imageURLString == rhs.imageURLString
	}
}
