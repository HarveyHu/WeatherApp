//
//  List.swift
//  Weather
//
//  Created by HarveyHu on 31/07/19.
//  Copyright © 2019 Harvey. All rights reserved.
//

import Foundation

struct List : Codable {

	let clouds : Cloud?
	let dt : Int?
	let dtTxt : String?
	let main : Main?
	let snow : Snow?
	let sys : Sys?
	let weather : [Weather]?
	let wind : Wind?


	enum CodingKeys: String, CodingKey {
		case clouds
		case dt = "dt"
		case dtTxt = "dt_txt"
		case main
		case snow
		case sys
		case weather = "weather"
		case wind
	}


}
