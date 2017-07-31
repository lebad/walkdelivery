//
//  DisplayedItemsViewController.swift
//  walkdelivery
//
//  Created by AndreyLebedev on 10/06/2017.
//  Copyright © 2017 lebedac. All rights reserved.
//

import UIKit
import SnapKit

class DisplayedItemsViewController: UIViewController {
	
	var output: DisplayedItemsViewOutput?
	
	var tableView: UITableView = {
		let tableView = UITableView(frame: CGRect.zero, style: .plain)
		tableView.backgroundColor = UIColor.clear
		tableView.register(DisplayedItemCell.self, forCellReuseIdentifier: String(describing: DisplayedItemCell.self))
		tableView.register(DisplayedItemSeparatorCell.self, forCellReuseIdentifier: String(describing: DisplayedItemSeparatorCell.self))
		return tableView
	}()
	
	var activityIndicator: UIActivityIndicatorView = {
		let activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.gray)
		activityIndicator.frame = CGRect.zero
		return activityIndicator
	}()

    override func viewDidLoad() {
        super.viewDidLoad()
		output?.viewPrepared()
    }
}

extension DisplayedItemsViewController: DisplayedItemsViewInput {
	
	func setupViews() {
		self.view.backgroundColor = UIColor.contentBackgroundColor()
		self.navigationController?.navigationBar.barTintColor = UIColor.navBarColor()
		setupTableView()
		setupActivityIndicator()
	}
	
	func show(items: [DisplayedItemViewModel]) {
		tableView.reloadData()
	}
	
	func show(errorString: String) {
		let alert = UIAlertController(title: nil,
		                              message: errorString,
		                              preferredStyle: .alert)
		let okAction = UIAlertAction(title: "OK", style: .default)
		alert.addAction(okAction)
	}
	
	func setupTableView() {
		tableView.dataSource = self
		tableView.translatesAutoresizingMaskIntoConstraints = false
		tableView.rowHeight = UITableViewAutomaticDimension
		tableView.estimatedRowHeight = 5.0
		tableView.tableFooterView = UIView()
		tableView.separatorStyle = .none
		self.view.addSubview(tableView)
		tableView.snp.makeConstraints { make in
			make.size.equalToSuperview()
		}
	}
	
	func setupActivityIndicator() {
		self.view.addSubview(activityIndicator)
		activityIndicator.snp.makeConstraints { make in
			make.center.equalToSuperview()
		}
	}
}

extension DisplayedItemsViewController: UITableViewDataSource {
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		guard let innerOutput = output else { return 0 }
		return innerOutput.numberOfRows()
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		guard let output = self.output else { return UITableViewCell() }
		
		let viewModel = output.viewModel(indexPath.row)
		let cellType = viewModel.cellType()
		let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: cellType), for: indexPath) as! CellViewModelConfigurable
		cell.set(viewModel)
		return cell as! UITableViewCell
	}
}

extension DisplayedItemsViewController: TaskProgressShowable {
	
	func showStart() {
		activityIndicator.startAnimating()
	}
	
	func showFinish() {
		activityIndicator.stopAnimating()
	}
}
