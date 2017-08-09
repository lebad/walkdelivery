//
//  RootViewControllerAccecable.swift
//  walkdelivery
//
//  Created by AndreyLebedev on 09/08/2017.
//  Copyright © 2017 lebedac. All rights reserved.
//

import UIKit

protocol RootViewControllerAccecable {
	var rootViewController: UINavigationController? { get }
}

extension RootViewControllerAccecable {
	
	var rootViewController: UINavigationController? {
		get {
			let appDelegate = UIApplication.shared.delegate as? AppDelegate
			let window = appDelegate?.window
			return window?.rootViewController as? UINavigationController
		}
	}
}
