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

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension DisplayedItemsViewController: DisplayedItemsViewInput {
	
}
