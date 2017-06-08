//
//  DisplayedItemsAssembly.swift
//  walkdelivery
//
//  Created by andrey on 08/06/2017.
//  Copyright © 2017 lebedac. All rights reserved.
//

import UIKit

class DisplayedItemsAssembly {
	
	var itemsDownloadObserver: ItemsDownloadNotifiable?
	
	func configureView() -> UIViewController {
		let viewController = DisplayedItemsViewController()
		let interactor = DisplayedItemsInteractor()
		
		let presenter = DisplayedItemsPresenter()
		presenter.view = viewController
		presenter.interactor = interactor
		
		itemsDownloadObserver = presenter
		
		viewController.output = presenter
		interactor.output = presenter
		
		return viewController
	}
}
