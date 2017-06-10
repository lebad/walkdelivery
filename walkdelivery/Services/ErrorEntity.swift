//
//  ErrorEntity.swift
//  walkdelivery
//
//  Created by AndreyLebedev on 27/05/2017.
//  Copyright © 2017 lebedac. All rights reserved.
//

import Foundation

struct ErrorEntity: Error {
	let description: String
}

extension ErrorEntity: Equatable {
	static func ==(lhs: ErrorEntity, rhs: ErrorEntity) -> Bool {
		return lhs.description == rhs.description
	}
}
