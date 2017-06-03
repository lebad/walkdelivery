//
//  InitialFlowItemsRouterInterface.swift
//  walkdelivery
//
//  Created by AndreyLebedev on 03/06/2017.
//  Copyright © 2017 lebedac. All rights reserved.
//

import Foundation

protocol InitialFlowItemsRouterInput: class {
	func routeToAuthScene()
	func routeToDisplayedItemsScene()
}

protocol InitialFlowItemsRouterOutput: class {
	
}
