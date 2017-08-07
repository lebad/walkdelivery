//
//  MoneyServiceProtocol.swift
//  walkdelivery
//
//  Created by AndreyLebedev on 07/08/2017.
//  Copyright © 2017 lebedac. All rights reserved.
//

import Foundation

enum CurrencyResult<U> {
	case Success(U)
	case Failure(CurrencyError)
}

enum CurrencyError: Error {
	case InnerError
}

protocol MoneyServiceProtocol: class {
	func getCurrency(code: String, completionHandler: @escaping (CurrencyResult<CurrencyEntity>) -> Void)
}
