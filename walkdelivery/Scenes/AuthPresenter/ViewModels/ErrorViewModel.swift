//
//  ErrorViewModel.swift
//  walkdelivery
//
//  Created by AndreyLebedev on 07/06/2017.
//  Copyright © 2017 lebedac. All rights reserved.
//

import Foundation

struct ErrorViewModel {
	let description: String
}

extension ErrorViewModel: Equatable {
	static func ==(left: ErrorViewModel, right: ErrorViewModel) -> Bool {
		return left.description == right.description
	}
}


