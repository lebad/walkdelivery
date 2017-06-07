//
//  AuthSceneInteractorTests.swift
//  walkdelivery
//
//  Created by AndreyLebedev on 07/06/2017.
//  Copyright © 2017 lebedac. All rights reserved.
//

@testable import walkdelivery
import XCTest

class AuthServiceMock: AuthServiceProtocol {
	
	var request: RequestUser?
	var requestAuthResult: AuthResult?
	
	func checkAuth(completionHandler: @escaping (AuthResult) -> Void) {
		
	}
	
	func requestAuth(request: RequestUser, completionHandler: @escaping (AuthResult) -> Void) {
		self.request = request
		
		guard let result = requestAuthResult else { return }
		completionHandler(result)
	}
	
	func listenAuthState(completionHandler: @escaping (AuthResult) -> Void) {
		
	}
}

class AuthScenePresenterMock: AuthSceneInteractorOutput {
	
	var user: UserEntity?
	var presentErrorCalled = false
	
	func presentSuccessSignup(user: UserEntity) {
		self.user = user
	}
	
	func presentError() {
		presentErrorCalled = true
	}
}

class AuthSceneInteractorTests: XCTestCase {
	
	var authSceneInteractor = AuthSceneInteractor()
	var authServiceMock: AuthServiceMock!
	var presenter: AuthScenePresenterMock!
	
	override func setUp() {
		super.setUp()
		presenter = AuthScenePresenterMock()
		authSceneInteractor.output = presenter
	}
	
	func testRequestSignUpToResendDataToService() {
		let request = RequestUser(email: "dffs@email.com", password: "passwertdf345")
		authServiceMock = AuthServiceMock()
		authSceneInteractor.authService = authServiceMock
		
		let loginViewModel = LoginViewModel(email: request.email, password: request.password)
		authSceneInteractor.requestSignup(model: loginViewModel)
		
		XCTAssertEqual(authServiceMock.request, request)
	}
	
	func testSuccessRequestSignUpToPresentSuccesSignUpAndResendUser() {
		let request = RequestUser(email: "dffs@email.com", password: "passwertdf345")
		authServiceMock = AuthServiceMock()
		let userEntity = UserEntity(uid: "2332", name: "Bob Bohinsky")
		authServiceMock.requestAuthResult = .Success(userEntity) as AuthResult
		authSceneInteractor.authService = authServiceMock
		
		let loginViewModel = LoginViewModel(email: request.email, password: request.password)
		authSceneInteractor.requestSignup(model: loginViewModel)
		
		XCTAssertEqual(presenter.user, userEntity)
	}
	
	func testNotSuccessRequestSignUpToPresentError() {
		authServiceMock = AuthServiceMock()
		authServiceMock.requestAuthResult = .NotRegistered as AuthResult
		authSceneInteractor.authService = authServiceMock
		presenter = AuthScenePresenterMock()
		authSceneInteractor.output = presenter
		
		let loginViewModel = LoginViewModel(email: "dffs@email.com", password: "dffs@email.com")
		authSceneInteractor.requestSignup(model: loginViewModel)
		
		XCTAssertNil(presenter.user)
		XCTAssertTrue(presenter.presentErrorCalled)
	}
}
