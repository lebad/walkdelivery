//
//  ViewModelCellRepresentable.swift
//  walkdelivery
//
//  Created by andrey on 18/06/2017.
//  Copyright © 2017 lebedac. All rights reserved.
//

import UIKit

protocol ViewModelCellRepresentable {
	func cellType() -> UITableViewCell.Type
}

protocol CellViewModelConfigurable {
	func set(_ viewModel: ViewModelCellRepresentable)
}
