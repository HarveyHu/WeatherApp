//
//  Sys.swift
//  Weather
//
//  Created by HarveyHu on 31/07/19.
//  Copyright © 2019 Harvey. All rights reserved.
//

import Foundation

struct Sys : Codable {

	let pod : String?


	enum CodingKeys: String, CodingKey {
		case pod = "pod"
	}


}
