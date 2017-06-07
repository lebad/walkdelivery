//
//  AuthScenePresenterTests.swift
//  walkdelivery
//
//  Created by AndreyLebedev on 07/06/2017.
//  Copyright © 2017 lebedac. All rights reserved.
//

@testable import walkdelivery
import XCTest

class AuthViewMock: AuthViewInput {
	
	var setupViewsCalled = false
	var enterModel: EnterLoginViewModel?
	var errorModel: ErrorViewModel?
	
	func setupViews() {
		setupViewsCalled = true
	}
	
	func showSignupRequest(model: EnterLoginViewModel) {
		enterModel = model
	}
	
	func show(errorModel: ErrorViewModel) {
		self.errorModel = errorModel
	}
}

class AuthInteractorMock: AuthSceneInteractorInput {
	
	var model: LoginViewModel?
	
	func requestSignup(model: LoginViewModel) {
		self.model = model
	}
}

class AuthScenePresenterTests: XCTestCase {
	
	var authScenePresenter = AuthScenePresenter()
	var authViewMock: AuthViewMock!
	var authInteractor: AuthInteractorMock!
    
    override func setUp() {
        super.setUp()
		authViewMock = AuthViewMock()
		authScenePresenter.view = authViewMock
		
		authInteractor = AuthInteractorMock()
		authScenePresenter.interactor = authInteractor
    }
    
    override func tearDown() {
        super.tearDown()
    }
	
	func testWhenViewIsPreparedSetupViews() {
		authScenePresenter.viewPrepared()
		
		XCTAssertTrue(authViewMock.setupViewsCalled, "setupViews didn't call")
	}
	
	func testWhenRequestSignupShowSignupRequest() {
		let email = "Enter your email"
		let password = "Enter your password"
		
		authScenePresenter.requestSignup()
		
		XCTAssertNotNil(authViewMock.enterModel, "Enter model didn't receive")
		XCTAssertEqual(authViewMock.enterModel?.email, email)
		XCTAssertEqual(authViewMock.enterModel?.password, password)
	}
	
	func testWhenEnteredValidLoginViewModelRequestSignUp() {
		let loginViewModel = LoginViewModel(email: "356ghd74@mail.com", password: "qwerty34tre")
		
		authScenePresenter.entered(loginViewModel: loginViewModel)
		
		XCTAssertEqual(authInteractor.model, loginViewModel)
	}
	
	func testWhenEnteredNotValidLoginShowError() {
		let errorModel = ErrorViewModel(description: "Not Valid Data. Please repeat.")
		
		var loginViewModel = LoginViewModel(email: "356g", password: "qwerty34tre")
		authScenePresenter.entered(loginViewModel: loginViewModel)
		authScenePresenter.interactor = AuthInteractorMock()
		XCTAssertNil(authInteractor.model)
		XCTAssertEqual(authViewMock.errorModel, errorModel)
		
		loginViewModel = LoginViewModel(email: "356g", password: nil)
		authScenePresenter.entered(loginViewModel: loginViewModel)
		authScenePresenter.interactor = AuthInteractorMock()
		XCTAssertNil(authInteractor.model)
		XCTAssertEqual(authViewMock.errorModel, errorModel)
		
		loginViewModel = LoginViewModel(email: nil, password: "hgsg445")
		authScenePresenter.entered(loginViewModel: loginViewModel)
		authScenePresenter.interactor = AuthInteractorMock()
		XCTAssertNil(authInteractor.model)
		XCTAssertEqual(authViewMock.errorModel, errorModel)
		
		loginViewModel = LoginViewModel(email: "", password: "")
		authScenePresenter.entered(loginViewModel: loginViewModel)
		authScenePresenter.interactor = AuthInteractorMock()
		XCTAssertNil(authInteractor.model)
		XCTAssertEqual(authViewMock.errorModel, errorModel)
	}
}
