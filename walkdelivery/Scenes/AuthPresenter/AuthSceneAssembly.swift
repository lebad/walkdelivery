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
		
		let presenter = AuthScenePresenter()
		presenter.view = viewController
		presenter.interactor = interactor
		
		viewController.output = presenter
		interactor.output = presenter
		
		return viewController
	}
}
