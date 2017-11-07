//
//  LocationManager.swift
//  walkDeliveryBusiness
//
//  Created by AndreyLebedev on 25/10/2017.
//  Copyright © 2017 AndreyLebedev. All rights reserved.
//

import Foundation
import CoreLocation

protocol LocationManagerInput: class {
	func addObserver(observer: LocationManagerObserver)
	func removeObserver(observer: LocationManagerObserver)
	func startUpdatingLocation()
	func stopUpdatingLocation()
}

protocol LocationManagerObserver: class {
	func didUpdate(_ location: CLLocationCoordinate2D)
	func didAuthFail()
}

fileprivate typealias RequestAuthComplete = (_ status: LocationManagerAuthStatus) -> Void
fileprivate enum LocationManagerAuthStatus: Int32 {
	case fail
	case success
}

class LocationManager: NSObject, LocationManagerInput {
	
	static var singleton = LocationManager()
	
	private lazy var locationManager: CLLocationManager = {
		let locManager = CLLocationManager()
		return locManager
	}()
	fileprivate var authCompletion: RequestAuthComplete?
	private var observers = NSHashTable<AnyObject>.weakObjects()
	
	func addObserver(observer: LocationManagerObserver) {
		observers.add(observer)
	}
	
	func removeObserver(observer: LocationManagerObserver) {
		observers.remove(observer)
	}
	
	func startUpdatingLocation() {
		requestAuthorization { [unowned self] complete in
			switch complete {
			case .fail:
				self.updateObservers { ($0 as? LocationManagerObserver)?.didAuthFail() }
			case .success:
				self.locationManager.delegate = self
				self.locationManager.startUpdatingLocation()
			}
		}
	}
	
	func stopUpdatingLocation() {
		locationManager.stopUpdatingLocation()
		locationManager.delegate = nil
	}
	
	fileprivate func requestAuthorization(_ complete: @escaping RequestAuthComplete ) {
		authCompletion = complete
		locationManager.requestWhenInUseAuthorization()
		locationManager.delegate = self
	}
	
	fileprivate func updateObservers(closure: (AnyObject) -> Void ) {
		observers.allObjects.forEach(closure)
	}
}

extension LocationManager: CLLocationManagerDelegate {
	
	func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
		guard status == .authorizedWhenInUse || status == .authorizedAlways else {return}
		authCompletion?(.success)
	}
	
	func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
		guard error._code == CLError.denied.rawValue || error._code == CLError.locationUnknown.rawValue else {return}
		authCompletion?(.fail)
	}
	
	func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
		guard let location = locations.first else {return}
		let currentLocation = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
		updateObservers { ($0 as? LocationManagerObserver)?.didUpdate(currentLocation) }
	}
}
