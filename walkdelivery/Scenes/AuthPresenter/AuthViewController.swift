//
//  AuthViewController.swift
//  walkdelivery
//
//  Created by AndreyLebedev on 03/06/2017.
//  Copyright © 2017 lebedac. All rights reserved.
//

import UIKit
import SnapKit

class AuthViewController: UIViewController {
	
	var output: AuthViewOutput?
	
	var loginView: LoginView = {
		let view = LoginView(frame: CGRect.zero)
		view.loginButton.addTarget(self, action: #selector(tap(loginButton:)), for: .touchUpInside)
		view.signupButton.addTarget(self, action: #selector(tap(signupButton:)), for: .touchUpInside)
		return view
	}()
	
	let LoginViewLeft: CGFloat = 30.0

    override func viewDidLoad() {
        super.viewDidLoad()
		output?.viewPrepared()
    }
	
	// MARK: Actions
	
	func tap(loginButton: UIButton) {
		self.output?.requestLogin()
	}
	
	func tap(signupButton: UIButton) {
		self.output?.requestSignup()
	}
}

extension AuthViewController: AuthViewInput {
	
	func setupViews() {
		view.translatesAutoresizingMaskIntoConstraints = false
		view.backgroundColor = UIColor.lightGray
		setupLoginView()
	}
	
	func setupLoginView() {
		loginView.textFieldEmail.delegate = self
		loginView.textFieldPassword.delegate = self
		
		self.view.addSubview(loginView)
		
		loginView.snp.makeConstraints { make in
			make.center.equalTo(self.view)
			make.leftMargin.equalTo(self.view).offset(LoginViewLeft)
			make.rightMargin.equalTo(self.view).offset(LoginViewLeft)
		}
		loginView.updateHeight()
	}
	
	func showSignupRequest() {
		let alert = UIAlertController(title: "Register",
		                              message: "Register",
		                              preferredStyle: .alert)
		let saveAction = UIAlertAction(title: "Save",
		style: .default) { action in
			guard let textFields = alert.textFields else { return }
			let emailField = textFields[0]
			let passwordField = textFields[1]
		}
	}
}

extension AuthViewController: UITextFieldDelegate {
	
	func textFieldShouldReturn(_ textField: UITextField) -> Bool {
		if textField == loginView.textFieldEmail {
			loginView.textFieldPassword.becomeFirstResponder()
		}
		if textField == loginView.textFieldPassword {
			loginView.textFieldPassword.resignFirstResponder()
		}
		
		return true
	}
}
