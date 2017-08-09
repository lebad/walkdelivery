//
//  DisplayedItemsViewInterface.swift
//  walkdelivery
//
//  Created by AndreyLebedev on 10/06/2017.
//  Copyright © 2017 lebedac. All rights reserved.
//

import Foundation

protocol DisplayedItemsViewInput: class {
	func setupViews()
	func show(items: [ViewModelCellRepresentable])
	func show(header: DisplayedItemsHeaderViewModel)
	func show(errorString: String)
}

protocol DisplayedItemsViewOutput: class {
	func viewPrepared()
	func numberOfRows() -> Int
	func viewModel(_ index: Int) -> ViewModelCellRepresentable
	func didSelectRow(_ index: Int)
}
