//
//  AuthViewInterface.swift
//  walkdelivery
//
//  Created by AndreyLebedev on 03/06/2017.
//  Copyright © 2017 lebedac. All rights reserved.
//

import Foundation

protocol AuthViewInput: class {
	func setupViews()
	func showSignupRequest(model: EnterLoginViewModel)
	func show(errorModel: ErrorViewModel)
}

protocol AuthViewOutput: class {
	func viewPrepared()
	func requestSignup()
	func entered(loginViewModel: LoginViewModel)
}
