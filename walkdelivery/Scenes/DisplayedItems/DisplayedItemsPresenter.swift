//
//  DisplayedItemsPresenter.swift
//  walkdelivery
//
//  Created by AndreyLebedev on 18/05/2017.
//  Copyright © 2017 lebedac. All rights reserved.
//

import Foundation

class DisplayedItemsPresenter {
	
	weak var view: DisplayedItemsViewInput?
	var interactor: DisplayedItemsInteractorInput?
}

extension DisplayedItemsPresenter: DisplayedItemsInteractorOutput {
	
}

extension DisplayedItemsPresenter: DisplayedItemsViewOutput {
	
}

extension DisplayedItemsPresenter: ItemsDownloadNotifiable {
	
	func didDownload(items: [ItemEntity]) {
		
	}
}
