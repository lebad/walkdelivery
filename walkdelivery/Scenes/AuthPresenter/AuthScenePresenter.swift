//
//  AuthFlowPresenter.swift
//  walkdelivery
//
//  Created by AndreyLebedev on 03/06/2017.
//  Copyright © 2017 lebedac. All rights reserved.
//

import Foundation

class AuthScenePresenter {
	
	weak var view: AuthViewInput?
	var interactor: AuthSceneInteractorInput?
}

extension AuthScenePresenter: AuthSceneInteractorOutput {
	
}

extension AuthScenePresenter: AuthViewOutput {
	
	func viewPrepared() {
		view?.setupViews()
	}
}
