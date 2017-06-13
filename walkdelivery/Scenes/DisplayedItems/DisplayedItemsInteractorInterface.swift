//
//  DisplayedItemsInteractorInterface.swift
//  walkdelivery
//
//  Created by AndreyLebedev on 10/06/2017.
//  Copyright © 2017 lebedac. All rights reserved.
//

import Foundation

protocol DisplayedItemsInteractorInput: class {
	func requestItems()
}

protocol DisplayedItemsInteractorOutput: class {
	func present(items: [ItemEntity])
	func present(error: ErrorEntity)
}
