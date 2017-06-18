//
//  DisplayedItemCell.swift
//  walkdelivery
//
//  Created by AndreyLebedev on 12/06/2017.
//  Copyright © 2017 lebedac. All rights reserved.
//

import UIKit

class DisplayedItemCell: UITableViewCell {
	
	var mainImageView: UIImageView = {
		let imageView = UIImageView(frame: CGRect.zero)
		imageView.translatesAutoresizingMaskIntoConstraints = false
		return imageView
	}()
	
	var nameLabel: UILabel = {
		let label = UILabel(frame: CGRect.zero)
		label.translatesAutoresizingMaskIntoConstraints = false
		label.numberOfLines = 0
		label.setContentHuggingPriority(1000, for: .vertical)
		label.setContentCompressionResistancePriority(1000, for: .vertical)
		return label
	}()
	
	var desciptionLabel: UILabel = {
		let label = UILabel(frame: CGRect.zero)
		label.translatesAutoresizingMaskIntoConstraints = false
		label.numberOfLines = 0
		label.setContentCompressionResistancePriority(1000, for: .vertical)
		return label
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
	private let MainImageViewLeft = 8
	private let MainImageViewTop = 8
	private let MainImageViewWidthPersent: CGFloat = 0.3
	private let MainImageViewBottom = 8
	private let NameLabelLeft = 8
	private let NameLabelTop = 8
	private let NameLabelRight = 8
	private let NameLabelBottom = 8
	private let DescriptionLeft = 8
	private let DescriptionRight = 8
	private let DescriptionBottom = 8
	
	private func setupViews() {
		self.translatesAutoresizingMaskIntoConstraints = false
		contentView.addSubview(mainImageView)
		contentView.addSubview(nameLabel)
		contentView.addSubview(desciptionLabel)
		self.setNeedsUpdateConstraints()
	}
	
	override func updateConstraints() {
		if didSetupConstraints == false {
			setupMainImageViewConstraints()
			setupNameLabelConstraints()
			setupDescriptionLabelConstraints()
		}
		super.updateConstraints()
	}
	
	private func setupMainImageViewConstraints() {
		let width = contentView.bounds.width * MainImageViewWidthPersent
		mainImageView.snp.makeConstraints { make in
			make.left.equalTo(MainImageViewLeft)
			make.top.equalTo(MainImageViewTop)
			make.width.equalTo(width)
			make.height.equalTo(width)
			make.bottom.greaterThanOrEqualTo(8)
		}
	}
	
	private func setupNameLabelConstraints() {
		nameLabel.snp.makeConstraints { make in
			make.top.equalTo(NameLabelTop)
			make.leading.equalTo(mainImageView).offset(NameLabelLeft)
			make.trailing.equalTo(NameLabelRight)
			make.bottom.equalTo(desciptionLabel).offset(NameLabelBottom)
		}
	}
	
	private func setupDescriptionLabelConstraints() {
		desciptionLabel.snp.makeConstraints { make in
			make.leading.equalTo(mainImageView).offset(DescriptionLeft)
			make.trailing.equalTo(DescriptionRight)
			make.bottom.equalTo(DescriptionBottom)
		}
	}
}

extension DisplayedItemCell: CellViewModelConfigurable {
	
	func set(_ viewModel: ViewModelCellRepresentable) {
		guard let currentViewModel = viewModel as? DisplayedItemViewModel else {
			fatalError("viewModel has to be \(String(describing: DisplayedItemViewModel.self)) type")
		}
		
		nameLabel.text = currentViewModel.name
	}
}

extension DisplayedItemViewModel: ViewModelCellRepresentable {
	
	func cellType() -> UITableViewCell.Type {
		return DisplayedItemCell.self
	}
}
