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
		imageView.backgroundColor = UIColor.blue
		imageView.translatesAutoresizingMaskIntoConstraints = false
		return imageView
	}()
	
	var nameLabel: UILabel = {
		let label = UILabel(frame: CGRect.zero)
		label.backgroundColor = UIColor.red
		label.translatesAutoresizingMaskIntoConstraints = false
		label.numberOfLines = 0
		return label
	}()
	
	var desciptionLabel: UILabel = {
		let label = UILabel(frame: CGRect.zero)
		label.translatesAutoresizingMaskIntoConstraints = false
		label.numberOfLines = 0
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
	private let MainImageViewLeft: CGFloat = 8.0
	private let MainImageViewTop: CGFloat = 8.0
	private let MainImageViewWidthPersent: CGFloat = 0.3
	private let MainImageViewBottom: CGFloat = 8.0
	private let NameLabelLeft: CGFloat = 8.0
	private let NameLabelTop: CGFloat = 8.0
	private let NameLabelRight: CGFloat = 8.0
	private let NameLabelBottom: CGFloat = 8.0
	private let DescriptionLeft: CGFloat = 8.0
	private let DescriptionRight: CGFloat = 8.0
	private let DescriptionBottom: CGFloat = 8.0
	
	private func setupViews() {
		self.translatesAutoresizingMaskIntoConstraints = false
		self.contentView.backgroundColor = UIColor.green
		contentView.addSubview(mainImageView)
		contentView.addSubview(nameLabel)
//		contentView.addSubview(desciptionLabel)
		self.setNeedsUpdateConstraints()
	}
	
	override func updateConstraints() {
		if didSetupConstraints == false {
			setupMainImageViewConstraints()
			setupNameLabelConstraints()
//			setupDescriptionLabelConstraints()
		}
		super.updateConstraints()
	}
	
	private func setupMainImageViewConstraints() {
		let width = contentView.bounds.width * MainImageViewWidthPersent
		mainImageView.snp.makeConstraints { make in
			make.left.equalToSuperview().offset(MainImageViewLeft)
			make.top.equalToSuperview().offset(MainImageViewTop)
			make.width.equalTo(width)
			make.height.equalTo(width)
			make.bottom.equalToSuperview().offset(-MainImageViewBottom)
		}
	}
	
	private func setupNameLabelConstraints() {
		nameLabel.snp.makeConstraints { make in
			make.top.equalToSuperview().offset(NameLabelTop)
			make.left.equalTo(mainImageView.snp.right).offset(NameLabelLeft)
			make.right.equalToSuperview().offset(-NameLabelRight)
			make.bottom.greaterThanOrEqualTo(self.contentView.snp.bottom).priority(999)
		}
		nameLabel.setContentHuggingPriority(999, for: .vertical)
//		nameLabel.setContentCompressionResistancePriority(999, for: .vertical)
	}
	
	private func setupDescriptionLabelConstraints() {
		self.desciptionLabel.setContentCompressionResistancePriority(UILayoutPriorityRequired, for: .vertical)
		
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
//		nameLabel.text = "It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using 'Content here, content here', making it look like readable English. Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text, and a search for 'lorem ipsum' will uncover many web sites still in their infancy. Various versions have evolved over the years, sometimes by accident, sometimes on purpose (injected humour and the like)."
		desciptionLabel.text = currentViewModel.description
	}
}

extension DisplayedItemViewModel: ViewModelCellRepresentable {
	
	func cellType() -> UITableViewCell.Type {
		return DisplayedItemCell.self
	}
}
