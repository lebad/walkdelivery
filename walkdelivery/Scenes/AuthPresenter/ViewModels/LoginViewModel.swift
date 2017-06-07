//
//  LoginViewModel.swift
//  walkdelivery
//
//  Created by AndreyLebedev on 07/06/2017.
//  Copyright © 2017 lebedac. All rights reserved.
//

import Foundation

struct LoginViewModel {
	var email: String?
	var password: String?
}

extension LoginViewModel: Validatable {
	
	func isValid() -> Bool {
		guard let email = self.email, let password = self.password else {
			return false
		}
		guard !email.isEmpty, !password.isEmpty, email.isValidEmail() else {
			return false
		}
		return true
	}
}

protocol Validatable {
	func isValid() -> Bool
}

extension LoginViewModel : Equatable {
	static func ==(left: LoginViewModel, right: LoginViewModel) -> Bool {
		return left.email == right.email &&
			left.password == right.password
	}
}


