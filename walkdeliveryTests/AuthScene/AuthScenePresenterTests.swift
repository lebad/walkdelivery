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
		
		reloadPresenter()
    }
    
    override func tearDown() {
        super.tearDown()
    }
	
	func reloadPresenter() {
		authInteractor = AuthInteractorMock()
		authScenePresenter.interactor = authInteractor
		authViewMock = AuthViewMock()
		authScenePresenter.view = authViewMock
	}
	
	func testWhenViewIsPreparedSetupViews() {
		authViewMock = AuthViewMock()
		authScenePresenter.view = authViewMock
		
		authScenePresenter.viewPrepared()
		
		XCTAssertTrue(authViewMock.setupViewsCalled, "setupViews didn't call")
	}
	
	func testWhenRequestSignupShowSignupRequest() {
		let email = "Enter your email"
		let password = "Enter your password"
		authViewMock = AuthViewMock()
		authScenePresenter.view = authViewMock
		
		authScenePresenter.requestSignup()
		
		XCTAssertNotNil(authViewMock.enterModel, "Enter model didn't receive")
		XCTAssertEqual(authViewMock.enterModel?.email, email)
		XCTAssertEqual(authViewMock.enterModel?.password, password)
	}
	
	func testWhenEnteredValidLoginViewModelRequestSignUp() {
		authInteractor = AuthInteractorMock()
		authScenePresenter.interactor = authInteractor
		let loginViewModel = LoginViewModel(email: "fgghd@mail.com", password: "qwerty34tre")
		
		authScenePresenter.entered(loginViewModel: loginViewModel)
		
		XCTAssertEqual(authInteractor.model, loginViewModel)
	}
	
	func testWhenEnteredNotValidLoginShowError() {
		let errorModel = ErrorViewModel(description: "Not Valid Data. Please repeat.")
		
		//1
		reloadPresenter()
		var loginViewModel = LoginViewModel(email: "356g", password: "qwerty34tre")
		authScenePresenter.entered(loginViewModel: loginViewModel)
		
		XCTAssertNil(authInteractor.model)
		XCTAssertEqual(authViewMock.errorModel, errorModel)
		
		//2
		reloadPresenter()
		loginViewModel = LoginViewModel(email: "356g", password: nil)
		authScenePresenter.entered(loginViewModel: loginViewModel)
		
		XCTAssertNil(authInteractor.model)
		XCTAssertEqual(authViewMock.errorModel, errorModel)
		
		//3
		reloadPresenter()
		loginViewModel = LoginViewModel(email: nil, password: "hgsg445")
		authScenePresenter.entered(loginViewModel: loginViewModel)
		
		XCTAssertNil(authInteractor.model)
		XCTAssertEqual(authViewMock.errorModel, errorModel)
		
		//4
		reloadPresenter()
		loginViewModel = LoginViewModel(email: "", password: "")
		authScenePresenter.entered(loginViewModel: loginViewModel)
		
		XCTAssertNil(authInteractor.model)
		XCTAssertEqual(authViewMock.errorModel, errorModel)
	}
	
	func testWhenPresentErrorShowError() {
		let errorModel = ErrorViewModel(description: "Error was occured. Please try again.")
		
		authScenePresenter.presentError()
		
		XCTAssertEqual(authViewMock.errorModel, errorModel)
	}
}
