//
//  AuthServiceProtocol.swift
//  walkdelivery
//
//  Created by AndreyLebedev on 27/05/2017.
//  Copyright © 2017 lebedac. All rights reserved.
//

import Foundation

struct UserEntity {
	var uid: String?
	var name: String?
}

struct RequestUser {
	var email: String
	var password: String
}

enum AuthResult {
	case Success(UserEntity)
	case NotRegistered
	case UserChanged
	case Failure(AuthError)
}

enum AuthError: Error {
	case InnerError
}

protocol AuthServiceProtocol: class {
	func checkAuth(completionHandler: @escaping (AuthResult) -> Void)
	func requestAuth(request: RequestUser, completionHandler: @escaping (AuthResult) -> Void)
	func listenAuthState(completionHandler: @escaping (AuthResult) -> Void)
}

extension RequestUser: Equatable {
	static func ==(lhs: RequestUser, rhs: RequestUser) -> Bool {
		return lhs.email == rhs.email &&
			   lhs.password == rhs.password
	}
}

extension UserEntity: Equatable {
	static func ==(lhs: UserEntity, rhs: UserEntity) -> Bool {
		return lhs.uid == lhs.uid
	}
}
