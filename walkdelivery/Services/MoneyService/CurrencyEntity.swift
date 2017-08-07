//
//  CurrencyEntity.swift
//  walkdelivery
//
//  Created by andrey on 06/08/2017.
//  Copyright © 2017 lebedac. All rights reserved.
//

import Foundation

struct CurrencyEntity {
	var code: String
	var name: String
	var sign: String
}

extension CurrencyEntity: DictionaryConvertable {
	
	init(dict: [String: Any]) {
		let code = dict["code"] as? String ?? ""
		let name = dict["name"] as? String ?? ""
		let sign = dict["sign"] as? String ?? ""
		self.init(code: code, name: name, sign: sign)
	}
	
	func convertToDict() -> [String: Any] {
		let dict = ["code": code,
		            "name": name,
		            "sign": sign]
		return dict
	}
}
