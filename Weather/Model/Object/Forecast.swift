//
//  Forecast.swift
//  Weather
//
//  Created by HarveyHu on 31/07/19.
//  Copyright © 2019 Harvey. All rights reserved.
//

import Foundation

struct Forecast : Codable {

	let city : City?
	let cnt : Int?
	let cod : String?
	let list : [List]?
	let message : Float?


	enum CodingKeys: String, CodingKey {
		case city
		case cnt = "cnt"
		case cod = "cod"
		case list = "list"
		case message = "message"
	}


}
