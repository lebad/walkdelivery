//
//  AuthSceneInteractorInterface.swift
//  walkdelivery
//
//  Created by AndreyLebedev on 03/06/2017.
//  Copyright © 2017 lebedac. All rights reserved.
//

import Foundation

protocol AuthSceneInteractorInput: class {
	func requestSignup(model: LoginViewModel)
}

protocol AuthSceneInteractorOutput: class {
	func presentSuccessSignup(user: UserEntity)
	func presentError()
}
