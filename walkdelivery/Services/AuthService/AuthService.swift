//
//  AuthenticationService.swift
//  walkdelivery
//
//  Created by AndreyLebedev on 27/05/2017.
//  Copyright © 2017 lebedac. All rights reserved.
//

import Foundation
import Firebase

class AuthService: AuthServiceProtocol {
	
	static let sharedInstance = AuthService()
	
	private var firAuth: Auth? = {
		guard let app = FirebaseApp.app(name: "User")
			else { assert(false, "Could not retrieve User app") }
		let auth = Auth.auth(app: app)
		return auth
	}()
	
	private var request: RequestUser?
	private var requestCompletionHanler: ((AuthResult) -> Void)?
	
	func checkAuth(completionHandler: @escaping (AuthResult) -> Void) {
		if let user = firAuth?.currentUser {
			let userEntity = UserEntity(uid: user.uid, name: user.displayName)
			completionHandler(.Success(userEntity))
		} else {
			completionHandler(.NotRegistered)
		}
	}
	
	func requestAuth(request: RequestUser, completionHandler: @escaping (AuthResult) -> Void) {
		self.request = request
		requestCompletionHanler = completionHandler
		requestAuth()
	}
	
	func listenAuthState(completionHandler: @escaping (AuthResult) -> Void) {
		firAuth?.addStateDidChangeListener { auth, user in
			
			if user == nil {
				completionHandler(.NotRegistered)
			} else {
				completionHandler(.UserChanged)
			}
		}
	}
	
	private func requestAuth() {
		guard let request = self.request else { return }
		
		self.firAuth?.createUser(withEmail: request.email,
		password: request.password) { [weak self] user, error in
			
			guard error == nil else {
				self?.requestCompletionHanler?(.Failure(.InnerError))
				return
			}
			
			self?.signIn()
		}
	}
	
	private func signIn() {
		guard let request = self.request else { return }
		
		self.firAuth?.signIn(withEmail: request.email,
		password: request.password) { [weak self] user, error in
			
			guard let currentUser = user ,error == nil else {
				self?.requestCompletionHanler?(.Failure(.InnerError))
				return
			}
			
			let userEntity = UserEntity(uid: currentUser.uid, name: currentUser.displayName)
			self?.requestCompletionHanler?(.Success(userEntity))
		}
	}
}
