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
		tableView.register(DisplayedItemCell.self, forCellReuseIdentifier: String(describing: DisplayedItemCell.self))
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
		self.view.backgroundColor = UIColor.white
		setupTableView()
		setupActivityIndicator()
	}
	
	func setupTableView() {
		tableView.dataSource = self
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
		return UITableViewCell()
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
