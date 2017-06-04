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
	
	var loginView = LoginView(frame: CGRect.zero)
	
	let LoginViewLeft: CGFloat = 30.0

    override func viewDidLoad() {
        super.viewDidLoad()
		output?.viewPrepared()
    }
}

extension AuthViewController: AuthViewInput {
	
	func setupViews() {
		view.translatesAutoresizingMaskIntoConstraints = false
		view.backgroundColor = UIColor.lightGray
		setupLoginView()
	}
	
	func setupLoginView() {
		self.view.addSubview(loginView)
		
		loginView.snp.makeConstraints { make in
			make.center.equalTo(self.view)
			make.leftMargin.equalTo(self.view).offset(LoginViewLeft)
			make.rightMargin.equalTo(self.view).offset(LoginViewLeft)
		}
		loginView.updateHeight()
	}
}
