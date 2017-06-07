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
	
	func presentSuccessSignup(user: UserEntity) {
		
	}
	
	func presentError() {
		
	}
}

extension AuthScenePresenter: AuthViewOutput {
	
	func entered(loginViewModel: LoginViewModel) {
		
		guard loginViewModel.isValid() else {
			let errorModel = ErrorViewModel(description: "Not Valid Data. Please repeat.")
			view?.show(errorModel: errorModel)
			return
		}
		
		interactor?.requestSignup(model: loginViewModel)
	}
	
	func viewPrepared() {
		view?.setupViews()
	}
	
	func requestSignup() {
		let enterModel = EnterLoginViewModel(email: "Enter your email",
		                                     password: "Enter your password")
		view?.showSignupRequest(model: enterModel)
	}
	
}
