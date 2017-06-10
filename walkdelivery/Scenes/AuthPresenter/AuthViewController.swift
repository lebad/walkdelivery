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
		
	}
	
	func tap(signupButton: UIButton) {
		self.output?.requestSignup()
	}
}

extension AuthViewController: AuthViewInput {
	
	func setupViews() {
		view.backgroundColor = UIColor.lightGray
		setupLoginView()
	}
	
	func setupLoginView() {
		loginView.textFieldEmail.delegate = self
		loginView.textFieldPassword.delegate = self
		
		self.view.addSubview(loginView)
		
		loginView.snp.makeConstraints { make in
			let superView = self.view!
			make.center.equalTo(superView)
			let width = superView.bounds.width - 2 * LoginViewLeft;
			make.width.equalTo(width)
		}
		loginView.updateHeight()
	}
	
	func showSignupRequest(model: EnterLoginViewModel) {
		let alert = UIAlertController(title: "Register",
		                              message: "Register",
		                              preferredStyle: .alert)
		let saveAction = UIAlertAction(title: "Save",
		style: .default) { action in
			guard let textFields = alert.textFields else { return }
			let emailField = textFields[0]
			let passwordField = textFields[1]
			
			var loginViewModel = LoginViewModel()
			loginViewModel.email = emailField.text
			loginViewModel.password = passwordField.text
			
			self.output?.entered(loginViewModel: loginViewModel)
		}
		
		let cancelAction = UIAlertAction(title: "Cancel", style: .default)
		
		alert.addAction(saveAction)
		alert.addAction(cancelAction)
		
		alert.addTextField { textEmail in
			textEmail.placeholder = model.email
		}
		alert.addTextField { textPassword in
			textPassword.isSecureTextEntry = true
			textPassword.placeholder = model.password
		}
		present(alert, animated: true, completion: nil)
	}
	
	func show(errorModel: ErrorViewModel) {
		let alert = UIAlertController(title: nil,
		                              message: errorModel.description,
		                              preferredStyle: .alert)
		let okAction = UIAlertAction(title: "OK", style: .default)
		alert.addAction(okAction)
		present(alert, animated: true, completion: nil)
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
