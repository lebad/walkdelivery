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
	
	// MARK: Views
	var loginView = UIView(frame: CGRect.zero)
	var textFieldEmail: UITextField = {
		let textField = UITextField(frame: CGRect.zero)
		textField.translatesAutoresizingMaskIntoConstraints = false
		textField.borderStyle = UITextBorderStyle.roundedRect
		textField.backgroundColor = UIColor.white
		textField.placeholder = "Email"
		return textField
	}()
	var textFieldPassword: UITextField = {
		let textField = UITextField(frame: CGRect.zero)
		textField.translatesAutoresizingMaskIntoConstraints = false
		textField.borderStyle = UITextBorderStyle.roundedRect
		textField.backgroundColor = UIColor.white
		textField.placeholder = "Password"
		return textField
	}()
	var loginButton: UIButton = {
		let button = UIButton(type: UIButtonType.custom)
		button.translatesAutoresizingMaskIntoConstraints = false
		button.setTitle("Login", for: .normal)
		button.titleLabel?.textAlignment = NSTextAlignment.center
		button.titleLabel?.textColor = UIColor.white
		button.backgroundColor = UIColor.orange
		return button
	}()
	var signupButton: UIButton = {
		let button = UIButton(type: UIButtonType.custom)
		button.translatesAutoresizingMaskIntoConstraints = false
		button.setTitle("Sign up", for: .normal)
		button.titleLabel?.textAlignment = NSTextAlignment.center
		button.titleLabel?.textColor = UIColor.white
		button.backgroundColor = UIColor.clear
		return button
	}()
	
	// MARK: Constants
	let LoginViewLeft: CGFloat = 30.0
	let LoginViewVertOffset: CGFloat = 7.0
	let LoginButtonTop: CGFloat = 15.0
	let SignupButtonTop: CGFloat = 10.0

    override func viewDidLoad() {
        super.viewDidLoad()
		output?.viewPrepared()
    }
}

extension AuthViewController: AuthViewInput {
	
	func setupViews() {
		view.translatesAutoresizingMaskIntoConstraints = false
		view.backgroundColor = UIColor.green
		setupLoginView()
	}
	
	func setupLoginView() {
		self.view.addSubview(loginView)
		loginView.backgroundColor = UIColor.red
		setupEmailView()
		setupPasswordView()
		setupLoginButton()
		setupSignupButton()
		
		self.view.layoutIfNeeded()
		
		let loginViewHeight = textFieldEmail.frame.height + LoginViewVertOffset + textFieldPassword.frame.height +
						      LoginButtonTop + loginButton.frame.height + SignupButtonTop + signupButton.frame.height
		loginView.snp.makeConstraints { make in
			make.height.equalTo(loginViewHeight)
			make.center.equalTo(self.view)
			make.leftMargin.equalTo(self.view).offset(LoginViewLeft)
			make.rightMargin.equalTo(self.view).offset(LoginViewLeft)
		}
	}
	
	func setupEmailView() {
		loginView.addSubview(textFieldEmail)
		textFieldEmail.snp.makeConstraints { make in
			make.top.equalTo(loginView.snp.top)
			make.left.equalTo(loginView)
			make.right.equalTo(loginView)
		}
	}
	
	func setupPasswordView() {
		loginView.addSubview(textFieldPassword)
		textFieldPassword.snp.makeConstraints { make in
			make.top.equalTo(textFieldEmail.snp.bottom).offset(LoginViewVertOffset)
			make.left.equalTo(loginView)
			make.right.equalTo(loginView)
		}
	}
	
	func setupLoginButton() {
		loginView.addSubview(loginButton)
		loginButton.snp.makeConstraints { make in
			make.top.equalTo(textFieldPassword.snp.bottom).offset(LoginButtonTop)
			make.left.equalTo(loginView)
			make.right.equalTo(loginView)
		}
	}
	
	func setupSignupButton() {
		loginView.addSubview(signupButton)
		signupButton.snp.makeConstraints { make in
			make.top.equalTo(loginButton.snp.bottom).offset(SignupButtonTop)
			make.left.equalTo(loginView)
			make.right.equalTo(loginView)
		}
	}
}
