//
//  AuthViewController.swift
//  walkdelivery
//
//  Created by AndreyLebedev on 03/06/2017.
//  Copyright © 2017 lebedac. All rights reserved.
//

import UIKit

class AuthViewController: UIViewController {
	
	var output: AuthViewOutput?

    override func viewDidLoad() {
        super.viewDidLoad()
		view.backgroundColor = UIColor.orange
    }
}

extension AuthViewController: AuthViewInput {
	
}
