//
//  ItemsDownloadNotifiable.swift
//  walkdelivery
//
//  Created by andrey on 08/06/2017.
//  Copyright © 2017 lebedac. All rights reserved.
//

import Foundation

protocol ItemsDownloadNotifiable: class {
	func didDownload(items: [ItemEntity])
}
