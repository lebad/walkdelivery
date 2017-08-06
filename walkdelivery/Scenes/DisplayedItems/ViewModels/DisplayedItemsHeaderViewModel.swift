//
//  DisplayedItemsHeaderViewModel.swift
//  walkdelivery
//
//  Created by andrey on 06/08/2017.
//  Copyright © 2017 lebedac. All rights reserved.
//

import Foundation

struct DisplayedItemsHeaderViewModel {
	var title: String
}

extension DisplayedItemsHeaderViewModel: Equatable {
	static func ==(lhs: DisplayedItemsHeaderViewModel, rhs: DisplayedItemsHeaderViewModel) -> Bool {
		return lhs.title == rhs.title
	}
}
