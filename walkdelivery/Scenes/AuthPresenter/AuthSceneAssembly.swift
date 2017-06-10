//
//  AuthSceneAssembly.swift
//  walkdelivery
//
//  Created by AndreyLebedev on 03/06/2017.
//  Copyright © 2017 lebedac. All rights reserved.
//

import UIKit

class AuthSceneAssembly {
	
	static func configureView() -> UIViewController {
		let viewController = AuthViewController()
		let interactor = AuthSceneInteractor()
		interactor.authService = AuthService.sharedInstance
		
		let presenter = AuthScenePresenter()
		presenter.view = viewController
		presenter.interactor = interactor
		presenter.router = AuthSceneRouter()
		
		viewController.output = presenter
		interactor.output = presenter
		
		return viewController
	}
	
}
