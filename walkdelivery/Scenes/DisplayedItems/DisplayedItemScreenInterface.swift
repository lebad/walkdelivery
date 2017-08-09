//
//  DisplayedItemScreenInterface.swift
//  walkdelivery
//
//  Created by AndreyLebedev on 09/08/2017.
//  Copyright © 2017 lebedac. All rights reserved.
//

import Foundation

protocol DisplayedItemScreenRouterInput: class {
	func routeToRequestingItem(_ item: ItemEntity)
}
