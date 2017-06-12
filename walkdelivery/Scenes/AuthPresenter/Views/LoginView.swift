//
//  LoginView.swift
//  walkdelivery
//
//  Created by AndreyLebedev on 03/06/2017.
//  Copyright © 2017 lebedac. All rights reserved.
//

import UIKit

class LoginView: UIView {
	
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
		let button = UIButton(type: UIButtonType.system)
		button.translatesAutoresizingMaskIntoConstraints = false
		button.setTitle("Login", for: .normal)
		button.titleLabel?.textAlignment = NSTextAlignment.center
		button.titleLabel?.textColor = UIColor.white
		button.backgroundColor = UIColor.orange
		return button
	}()
	var signupButton: UIButton = {
		let button = UIButton(type: UIButtonType.system)
		button.translatesAutoresizingMaskIntoConstraints = false
		button.setTitle("Sign up", for: .normal)
		button.titleLabel?.textAlignment = NSTextAlignment.center
		button.titleLabel?.textColor = UIColor.white
		button.backgroundColor = UIColor.clear
		return button
	}()
	
	private var didSetupConstraints = false
	
	// MARK: Constants
	private let LoginViewVertOffset: CGFloat = 7.0
	private let LoginButtonTop: CGFloat = 15.0
	private let SignupButtonTop: CGFloat = 10.0

	override init(frame: CGRect) {
		super.init(frame: frame)
		setup()
	}
	
	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
		setup()
	}
	
	func updateHeight() {
		self.layoutIfNeeded()
		let loginViewHeight = textFieldEmail.frame.height + LoginViewVertOffset + textFieldPassword.frame.height +
			LoginButtonTop + loginButton.frame.height + SignupButtonTop + signupButton.frame.height
		self.snp.makeConstraints { make in
			make.height.equalTo(loginViewHeight)
		}
	}
	
	private func setup() {
		self.translatesAutoresizingMaskIntoConstraints = false
		self.backgroundColor = UIColor.clear
		self.clipsToBounds = true
		
		self.addSubview(textFieldEmail)
		self.addSubview(textFieldPassword)
		self.addSubview(loginButton)
		self.addSubview(signupButton)
		
		self.setNeedsUpdateConstraints()
	}
	
	override func updateConstraints() {
		if didSetupConstraints == false {
			
			setupEmailViewConstraints()
			setupPasswordViewConstraints()
			setupLoginButtonConstrants()
			setupSignupButtonConstraints()
			
			didSetupConstraints = true
		}
		super.updateConstraints()
	}
	
	private func setupEmailViewConstraints() {
		textFieldEmail.snp.makeConstraints { make in
			make.top.equalTo(self.snp.top)
			make.left.equalTo(self)
			make.right.equalTo(self)
		}
	}
	
	private func setupPasswordViewConstraints() {
		textFieldPassword.snp.makeConstraints { make in
			make.top.equalTo(textFieldEmail.snp.bottom).offset(LoginViewVertOffset)
			make.left.equalTo(self)
			make.right.equalTo(self)
		}
	}
	
	private func setupLoginButtonConstrants() {
		loginButton.snp.makeConstraints { make in
			make.top.equalTo(textFieldPassword.snp.bottom).offset(LoginButtonTop)
			make.left.equalTo(self)
			make.right.equalTo(self)
		}
	}
	
	private func setupSignupButtonConstraints() {
		signupButton.snp.makeConstraints { make in
			make.top.equalTo(loginButton.snp.bottom).offset(SignupButtonTop)
			make.left.equalTo(self)
			make.right.equalTo(self)
		}
	}
}
