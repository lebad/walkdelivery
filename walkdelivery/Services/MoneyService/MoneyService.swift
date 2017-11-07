//
//  MoneyService.swift
//  walkdelivery
//
//  Created by AndreyLebedev on 07/08/2017.
//  Copyright © 2017 lebedac. All rights reserved.
//

import Foundation
import Firebase


//class MoneyService: MoneyServiceProtocol {
//	
//	func getCurrency(_ code: String, completionHandler: @escaping (CurrencyResult<CurrencyEntity>) -> Void) {
//		
//		FireBaseReferenceAccess.singleton.fireBaseReferenceUser?.child("currencies").child(code).observeSingleEvent(of: .value, with: { snapshot in
//			
//			guard var valueDict = snapshot.value as? [String: Any] else {
//				completionHandler(.Failure(.InnerError))
//				return
//			}
//			valueDict["code"] = snapshot.key
//			let currency = CurrencyEntity(dict: valueDict)
//			completionHandler(.Success(currency))
//		})
//	}
//}

