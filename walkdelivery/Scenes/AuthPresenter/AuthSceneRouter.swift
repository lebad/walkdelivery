//
//  AuthSceneRouter.swift
//  walkdelivery
//
//  Created by AndreyLebedev on 10/06/2017.
//  Copyright © 2017 lebedac. All rights reserved.
//

import UIKit

class AuthSceneRouter: AuthSceneRouterInput {
	
	private var rootViewController: UINavigationController? {
		get {
			let appDelegate = UIApplication.shared.delegate as? AppDelegate
			let window = appDelegate?.window
			return window?.rootViewController as? UINavigationController
		}
	}
	
	func routeToDisplayedItemsScene() {
		gp
		
		let displayedItemsVC = DisplayedItemsScreenAssembly.configureView()
		currentNavigationController.pushViewController(displayedItemsVC, animated: true)
	}
}
