//
//  DisplayedItemsViewController.swift
//  walkdelivery
//
//  Created by AndreyLebedev on 10/06/2017.
//  Copyright © 2017 lebedac. All rights reserved.
//

import UIKit

class DisplayedItemsViewController: UIViewController {
	
	var output: DisplayedItemsViewOutput?
	
	var tableView: UITableView = {
		let tableView = UITableView(frame: CGRect.zero, style: .plain)
		tableView.register(DisplayedItemCell.self, forCellReuseIdentifier: String(describing: DisplayedItemCell.self))
		return tableView
	}()

    override func viewDidLoad() {
        super.viewDidLoad()
		output?.viewPrepared()
    }
}

extension DisplayedItemsViewController: DisplayedItemsViewInput {
	
	func setupViews() {
		self.view.backgroundColor = UIColor.white
		self.tableView.dataSource = self
		self.view.addSubview(self.tableView)
	}
	
	func showDownloadingStarted() {
		
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
