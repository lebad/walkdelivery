//
//  FireBaseReferenceAccecable.swift
//  walkdelivery
//
//  Created by andrey on 11/08/2017.
//  Copyright © 2017 lebedac. All rights reserved.
//

import Foundation
import Firebase

class FireBaseReferenceAccess {
	
	static var singleton = FireBaseReferenceAccess()
	
	var fireBaseReferenceUser: DatabaseReference? = {
//		let filePath = Bundle.main.path(forResource: "GoogleService-Info-User", ofType: "plist")
//		guard let fileopts = FirebaseOptions.init(contentsOfFile: filePath!)
//			else { assert(false, "Could not retrieve GoogleService-Info-User") }
//		FirebaseApp.configure(name:"User", options:fileopts)
		guard let app = FirebaseApp.app(name: "User")
			else { assert(false, "Could not retrieve User app") }
		let dataBase = Database.database(app: app)
		let reference = dataBase.reference()
		return reference
	}()
	
	var fireBaseReferenceBusiness: DatabaseReference? = {
//		let filePath = Bundle.main.path(forResource: "GoogleService-Info-Business", ofType: "plist")
//		guard let fileopts = FirebaseOptions.init(contentsOfFile: filePath!)
//			else { assert(false, "Could not retrieve GoogleService-Info-Business") }
//		FirebaseApp.configure(name:"Business", options:fileopts)
		guard let app = FirebaseApp.app(name: "Business")
			else { assert(false, "Could not retrieve Business app") }
		let dataBase = Database.database(app: app)
		let reference = dataBase.reference()
		return reference
	}()
}
