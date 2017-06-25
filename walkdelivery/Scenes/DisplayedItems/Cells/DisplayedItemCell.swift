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
		return label
	}()
	
	var descriptionTextView: UITextView = {
		let textView = UITextView(frame: CGRect.zero)
		textView.backgroundColor = UIColor.brown
		textView.translatesAutoresizingMaskIntoConstraints = false
		textView.isEditable = false
		textView.dataDetectorTypes = UIDataDetectorTypes()
		textView.textContainer.lineFragmentPadding = 0;
		textView.textContainerInset = UIEdgeInsets.zero;
		textView.textContainer.lineBreakMode = .byTruncatingTail;
		return textView
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
		contentView.addSubview(descriptionTextView)
		self.setNeedsUpdateConstraints()
	}
	
	override func updateConstraints() {
		if didSetupConstraints == false {
			setupMainImageViewConstraints()
			setupNameLabelConstraints()
			setupDescriptionTextViewConstraint()
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
		}
		nameLabel.setContentHuggingPriority(UILayoutPriorityRequired, for: .vertical)
	}
	
	private func setupDescriptionTextViewConstraint() {
		descriptionTextView.snp.makeConstraints {make in
			make.top.equalTo(nameLabel.snp.bottom).offset(NameLabelBottom)
			make.left.equalTo(mainImageView.snp.right).offset(DescriptionLeft)
			make.right.equalToSuperview().offset(-DescriptionRight)
			make.bottom.equalToSuperview().offset(-DescriptionBottom)
		}
	}
}

extension DisplayedItemCell: CellViewModelConfigurable {
	
	func set(_ viewModel: ViewModelCellRepresentable) {
		guard let currentViewModel = viewModel as? DisplayedItemViewModel else {
			fatalError("viewModel has to be \(String(describing: DisplayedItemViewModel.self)) type")
		}
		nameLabel.text = currentViewModel.name
		descriptionTextView.text = currentViewModel.description
	}
}

extension DisplayedItemViewModel: ViewModelCellRepresentable {
	
	func cellType() -> UITableViewCell.Type {
		return DisplayedItemCell.self
	}
}
