//
//  InitialFlowItemsInteractor.swift
//  walkdelivery
//
//  Created by AndreyLebedev on 18/05/2017.
//  Copyright © 2017 lebedac. All rights reserved.
//

import Foundation

class InitialFlowItemsInteractor: InitialFlowItemsInteractorInput {
	
	var output: InitialFlowItemsInteractorOutput?
	var authService: AuthServiceProtocol?
	
	func startFlow() {
		
		authService?.checkAuth { [weak self] result in
			
			switch result {
			case .Success( _):
				self?.output?.presentDisplayedItemsScreen()
				self?.listenAuthChanges()
			case .NotRegistered:
				self?.output?.presentAuth()
			case .Failure( _):
				self?.output?.present(errorMessage: ErrorEntity(description: "Authorization Error"))
			default: break
			}
		}
	}
	
	func listenAuthChanges() {
		authService?.listenAuthState{ result in
			switch result {
			case.NotRegistered:
				self.output?.presentAuth()
			default: break
			}
		}
	}
}
