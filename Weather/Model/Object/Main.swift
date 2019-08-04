//
//  Main.swift
//  Weather
//
//  Created by HarveyHu on 31/07/19.
//  Copyright © 2019 Harvey. All rights reserved.
//

import Foundation

struct Main : Codable {

	let grndLevel : Float?
	let humidity : Int?
	let pressure : Float?
	let seaLevel : Float?
	let temp : Float?
	let tempKf : Float?
	let tempMax : Float?
	let tempMin : Float?


	enum CodingKeys: String, CodingKey {
		case grndLevel = "grnd_level"
		case humidity = "humidity"
		case pressure = "pressure"
		case seaLevel = "sea_level"
		case temp = "temp"
		case tempKf = "temp_kf"
		case tempMax = "temp_max"
		case tempMin = "temp_min"
	}
}
