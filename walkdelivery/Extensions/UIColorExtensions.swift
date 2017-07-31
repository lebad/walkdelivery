//
//  UIColorExtensions.swift
//  walkdelivery
//
//  Created by AndreyLebedev on 31/07/2017.
//  Copyright © 2017 lebedac. All rights reserved.
//

import UIKit

extension UIColor {
	static func navBarColor() -> UIColor {
		return UIColor(red: 247.0 / 255.0, green: 247.0 / 255.0, blue: 248.0 / 255.0, alpha: 1.0)
	}
	static func contentBackgroundColor() -> UIColor {
		return UIColor(red: 239.0 / 255.0, green: 239.0 / 255.0, blue: 244.0 / 255.0, alpha: 1.0)
	}
	static func displayedItemCellBackgroundColor() -> UIColor {
		return UIColor.white
	}
	static func backgroundPlaceholderImageColor() -> UIColor {
		return UIColor(red: 174.0 / 255.0, green: 174.0 / 255.0, blue: 174.0 / 255.0, alpha: 1.0)
	}
	static func mainTextColor() -> UIColor {
		return UIColor.black
	}
	static func descriptionTextColor() -> UIColor {
		return UIColor(red: 137.0 / 255.0, green: 137.0 / 255.0, blue: 137.0 / 255.0, alpha: 1.0)
	}
	static func displayedItemSeparatorColor() -> UIColor {
		return UIColor(red: 200.0 / 255.0, green: 199.0 / 255.0, blue: 204.0 / 255.0, alpha: 1.0)
	}
}
