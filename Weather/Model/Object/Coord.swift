//
//  Coord.swift
//  Weather
//
//  Created by HarveyHu on 31/07/19.
//  Copyright © 2019 Harvey. All rights reserved.
//

import Foundation

struct Coord : Codable {

	var lat : Float?
	var lon : Float?


	enum CodingKeys: String, CodingKey {
        case lon = "lon"
		case lat = "lat"
	}
}
