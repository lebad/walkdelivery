//
//  DisplayedItemsScreenAssembly.swift
//  walkdelivery
//
//  Created by AndreyLebedev on 10/06/2017.
//  Copyright © 2017 lebedac. All rights reserved.
//

import UIKit

class DisplayedItemsScreenAssembly {
	
	static func configureView() -> UIViewController {
		let viewController = DisplayedItemsViewController()
		let interactor = DisplayedItemsInteractor()
		interactor.itemsStoreService = ItemsStoreService()
		
		let presenter = DisplayedItemsPresenter()
		presenter.view = viewController
		presenter.interactor = interactor
		
		viewController.output = presenter
		interactor.output = presenter
		
		return viewController
	}
}
