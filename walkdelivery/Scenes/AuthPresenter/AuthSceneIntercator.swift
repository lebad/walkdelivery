//
//  AuthSceneIntercator.swift
//  walkdelivery
//
//  Created by AndreyLebedev on 03/06/2017.
//  Copyright © 2017 lebedac. All rights reserved.
//

import Foundation

class AuthSceneInteractor {
	
	weak var output: AuthSceneInteractorOutput?
	var authService: AuthServiceProtocol?
}

extension AuthSceneInteractor: AuthSceneInteractorInput {
	
	func requestSignup(model: LoginViewModel) {
		guard let email = model.email, let password = model.password else { return }
		
		let requestUser = RequestUser(email: email, password: password)
		authService?.requestAuth(request: requestUser) { [weak self] result in
			switch result {
			case .Success(let userEntity):
				self?.output?.presentSuccessSignup(user: userEntity)
			default:
				self?.output?.presentError()
			}
		}
	}
}
