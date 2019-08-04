//
//  Snow.swift
//  Weather
//
//  Created by HarveyHu on 31/07/19.
//  Copyright © 2019 Harvey. All rights reserved.
//

import Foundation

struct Snow : Codable {

    let hour : Double?

	enum CodingKeys: String, CodingKey {
        case hour = "3h"
	}


}
