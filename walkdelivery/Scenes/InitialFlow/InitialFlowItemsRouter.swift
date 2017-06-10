//
//  InitialFlowItemsRouter.swift
//  walkdelivery
//
//  Created by AndreyLebedev on 03/06/2017.
//  Copyright © 2017 lebedac. All rights reserved.
//

import UIKit

class InitialFlowItemsRouter: InitialFlowItemsRouterInput {
	
	private var window: UIWindow?
	private var controllerToShow: UIViewController?
	
	func routeToAuthScene() {
		createWindow()
		controllerToShow = AuthSceneAssembly.configureView()
		showController()
	}
	
	func routeToDisplayedItemsScene() {
		createWindow()
		controllerToShow = DisplayedItemsScreenAssembly.configureView()
		showController()
	}
	
	private func createWindow() {
		window = UIWindow(frame: UIScreen.main.bounds)
		guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
			return
		}
		appDelegate.window = window
	}
	
	private func showController() {
		guard let currentVC = controllerToShow else { return }
		
		let navVC = UINavigationController(rootViewController: currentVC)
		navVC.isNavigationBarHidden = true
		navVC.isToolbarHidden = true
		window?.rootViewController = navVC
		window?.makeKeyAndVisible()
	}
}
