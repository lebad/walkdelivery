//
//  AppDelegate.swift
//  walkdelivery
//
//  Created by AndreyLebedev on 16/05/2017.
//  Copyright © 2017 lebedac. All rights reserved.
//

import UIKit
import Firebase

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

	var window: UIWindow?

	var initialFlowInteractor: InitialFlowItemsInteractorInput?

	func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
		
		configureFireBaseReference("User")
		configureFireBaseReference("Business")
		
		initialFlowInteractor = InitialFlowItemsAssembly.configureInteractor()
		initialFlowInteractor?.startFlow()
		return true
	}
	
	func configureFireBaseReference(_ name: String) {
		let filePath = Bundle.main.path(forResource: "GoogleService-Info-" + name, ofType: "plist")
		guard let options = FirebaseOptions(contentsOfFile: filePath!)
			else { assert(false, "Couldn't load config file") }
		FirebaseApp.configure(name: name, options: options)
	}
}

