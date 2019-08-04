//
//  Cloud.swift
//  Weather
//
//  Created by HarveyHu on 31/07/19.
//  Copyright © 2019 Harvey. All rights reserved.
//

import Foundation

struct Cloud : Codable {

	let all : Int?


	enum CodingKeys: String, CodingKey {
		case all = "all"
	}


}
