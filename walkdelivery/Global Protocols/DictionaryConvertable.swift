//
//  DictionaryConvertable.swift
//  walkdelivery
//
//  Created by andrey on 06/08/2017.
//  Copyright © 2017 lebedac. All rights reserved.
//

import Foundation

protocol DictionaryConvertable {
	init(dict: [String: Any])
	func convertToDict() -> [String: Any]
}
