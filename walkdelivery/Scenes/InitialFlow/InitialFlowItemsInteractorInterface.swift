//
//  InitialFlowItemsInteractorInterface.swift
//  walkdelivery
//
//  Created by AndreyLebedev on 03/06/2017.
//  Copyright © 2017 lebedac. All rights reserved.
//

import Foundation

protocol InitialFlowItemsInteractorInput: class {
	func startFlow()
	func listenAuthChanges()
}

protocol InitialFlowItemsInteractorOutput: class {
	func presentDisplayedItemsScreen()
	func present(errorMessage: ErrorEntity)
	func presentAuth()
}
