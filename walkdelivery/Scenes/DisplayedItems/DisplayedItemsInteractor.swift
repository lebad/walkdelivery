//
//  DisplayedItemsInteractor.swift
//  walkdelivery
//
//  Created by AndreyLebedev on 10/06/2017.
//  Copyright © 2017 lebedac. All rights reserved.
//

import Foundation
import CoreLocation

class DisplayedItemsInteractor {
	
	weak var output: DisplayedItemsInteractorOutput?
	var itemsStoreService: ItemsStoreServiceProtocol?
	weak var locationManager: LocationManagerInput?
}

extension DisplayedItemsInteractor: DisplayedItemsInteractorInput {
	
	func requestItems() {
		locationManager?.addObserver(observer: self)
		locationManager?.startUpdatingLocation()
	}
}

extension DisplayedItemsInteractor: LocationManagerObserver {
	
	func didUpdate(_ location: CLLocationCoordinate2D) {
		print("location: \(location)")
		let request = ItemsRequest(customerLocationCoordinate: location, radius: 1)
		itemsStoreService?.getItems(request: request) { [weak self] result in
			switch result {
			case .Success(let remoteItems):
				self?.output?.present(items: remoteItems)
			case .Failure( _):
				self?.output?.present(error: ErrorEntity(description: ""))
			}
		}
	}
	
	func didAuthFail() {
		
	}
}
