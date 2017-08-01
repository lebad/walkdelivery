//
//  DisplayedItemSeparatorCell.swift
//  walkdelivery
//
//  Created by AndreyLebedev on 31/07/2017.
//  Copyright © 2017 lebedac. All rights reserved.
//

import UIKit

class DisplayedItemSeparatorCell: UITableViewCell {
	
	var separatorView: UIView = {
		let view = UIView(frame: CGRect.zero)
		view.backgroundColor = UIColor.displayedItemSeparatorColor()
		return view
	}()

	override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		setupViews()
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	private var didSetupConstraints = false
	
	// MARK: Constants
	private let SeparatorHeight: CGFloat = 1.0
	
	private func setupViews() {
		self.translatesAutoresizingMaskIntoConstraints = false
		contentView.addSubview(separatorView)
		self.setNeedsUpdateConstraints()
	}
	
	override func updateConstraints() {
		if didSetupConstraints == false {
			setupSeparatorHeightConstraint()
		}
		super.updateConstraints()
	}
	
	private func setupSeparatorHeightConstraint() {
		separatorView.snp.makeConstraints { make in
			make.height.equalTo(SeparatorHeight)
			make.size.equalToSuperview()
		}
	}
}

extension DisplayedItemSeparatorCell: CellViewModelConfigurable {
	
	func set(_ viewModel: ViewModelCellRepresentable) {
		guard viewModel is DisplayedItemSeparatorViewModel else {
			fatalError("viewModel has to be \(String(describing: DisplayedItemSeparatorViewModel.self)) type")
		}
	}
}

extension DisplayedItemSeparatorViewModel: ViewModelCellRepresentable {
	
	func cellType() -> UITableViewCell.Type {
		return DisplayedItemSeparatorCell.self
	}
}

