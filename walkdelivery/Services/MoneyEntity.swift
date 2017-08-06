//
//  MoneyEntity.swift
//  walkdelivery
//
//  Created by andrey on 06/08/2017.
//  Copyright © 2017 lebedac. All rights reserved.
//

import Foundation

struct MoneyEntity {
	var amount: NSDecimalNumber
	var currency: CurrencyEntity
}

extension MoneyEntity: DictionaryConvertable {
	
	init(dict: [String: Any]) {
		let amountString = dict["amount"] as? String ?? ""
		let amount = NSDecimalNumber(string: amountString)
		self.init(amount: amount, currency: CurrencyEntity(dict: [:]))
	}
	
	func convertToDict() -> [String: Any] {
		let dict = ["amount": amount.stringValue,
		            "currencyCode": currency.code]
		return dict
	}
}
