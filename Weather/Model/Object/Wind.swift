//
//  Wind.swift
//  Weather
//
//  Created by HarveyHu on 31/07/19.
//  Copyright © 2019 Harvey. All rights reserved.
//

import Foundation

struct Wind : Codable {

	let deg : Float?
	let speed : Float?


	enum CodingKeys: String, CodingKey {
		case deg = "deg"
		case speed = "speed"
	}

}
