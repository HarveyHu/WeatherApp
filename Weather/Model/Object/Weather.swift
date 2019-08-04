//
//  Weather.swift
//  Weather
//
//  Created by HarveyHu on 31/07/19.
//  Copyright © 2019 Harvey. All rights reserved.
//

import Foundation

struct Weather : Codable {

	let descriptionField : String?
	let icon : String?
	let id : Int?
	let main : String?


	enum CodingKeys: String, CodingKey {
		case descriptionField = "description"
		case icon = "icon"
		case id = "id"
		case main = "main"
	}

}
