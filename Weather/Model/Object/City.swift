//
//  City.swift
//  Weather
//
//  Created by HarveyHu on 31/07/19.
//  Copyright © 2019 Harvey. All rights reserved.
//

import Foundation

struct City : Codable {

	let coord : Coord?
	let country : String?
	let id : Int?
	let name : String?


	enum CodingKeys: String, CodingKey {
		case coord = "coord"
		case country = "country"
		case id = "id"
		case name = "name"
	}
    
}
