//
//  AuthServiceProtocol.swift
//  walkdelivery
//
//  Created by AndreyLebedev on 27/05/2017.
//  Copyright © 2017 lebedac. All rights reserved.
//

import Foundation

struct UserEntity {
	var id: String?
	var name: String?
}

struct RequestUser {
	var login: String
	var password: String
}

enum AuthResult {
	case Success(UserEntity)
	case NotRegistered
	case Failure(Error?)
}

protocol AuthServiceProtocol: class {
	func checkAuth(completionHandler: @escaping (AuthResult) -> Void)
	func requestAuth(request: RequestUser, completionHandler: @escaping (AuthResult) -> Void)
}
