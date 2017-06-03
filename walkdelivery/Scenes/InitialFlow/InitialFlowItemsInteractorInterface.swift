//
//  InitialFlowItemsInteractorInterface.swift
//  walkdelivery
//
//  Created by AndreyLebedev on 03/06/2017.
//  Copyright © 2017 lebedac. All rights reserved.
//

import Foundation

protocol InitialFlowItemsInteractorInput: class {
	func requestItems()
	func listenAuthChanges()
}

protocol InitialFlowItemsInteractorOutput: class {
	func present(items: [ItemEntity])
	func present(errorMessage: ErrorEntity)
	func presentAuth()
}
