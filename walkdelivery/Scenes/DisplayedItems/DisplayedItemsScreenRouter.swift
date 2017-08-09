//
//  DisplayedItemsScreenRouter.swift
//  walkdelivery
//
//  Created by AndreyLebedev on 09/08/2017.
//  Copyright © 2017 lebedac. All rights reserved.
//

import UIKit

class DisplayedItemsScreenRouter: DisplayedItemScreenRouterInput {
	
	private var rootViewController: UINavigationController? {
		get {
			let appDelegate = UIApplication.shared.delegate as? AppDelegate
			let window = appDelegate?.window
			return window?.rootViewController as? UINavigationController
		}
	}
	
	func routeToRequestingItem(_ item: ItemEntity) {
		guard let currentNavigationController = rootViewController,
		      let currentVC = currentNavigationController.topViewController else { return }
		
		let presentedVC = UIViewController()
		currentVC.present(presentedVC, animated: true, completion: nil)
	}
}
