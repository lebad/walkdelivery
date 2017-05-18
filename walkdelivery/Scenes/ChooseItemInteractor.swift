//
//  ChooseItemInteractor.swift
//  walkdelivery
//
//  Created by AndreyLebedev on 18/05/2017.
//  Copyright © 2017 lebedac. All rights reserved.
//

import Foundation

struct Item {
	
}

protocol ChooseItemInteractorInput: class {
	func requestItems()
}

protocol ChooseItemInteractorOutput: class {
	func receive(items: [Item])
}

class ChooseItemInteractor: ChooseItemInteractorInput {
	
	func requestItems() {
		
	}
}
