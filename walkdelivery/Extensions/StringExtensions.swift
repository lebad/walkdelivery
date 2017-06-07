//
//  StringExtensions.swift
//  walkdelivery
//
//  Created by AndreyLebedev on 07/06/2017.
//  Copyright © 2017 lebedac. All rights reserved.
//

import Foundation

extension String {
	func isValidEmail() -> Bool {
		let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
		let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
		return emailPredicate.evaluate(with: self)
	}
}
