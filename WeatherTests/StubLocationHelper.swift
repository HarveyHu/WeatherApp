//
//  StubLocationHelper.swift
//  WeatherTests
//
//  Created by SwipedOn on 4/08/19.
//  Copyright © 2019 Harvey. All rights reserved.
//

import UIKit
@testable import Weather

class StubLocationHelper: LocationHelper {
    override func getCurrentCityName(completion: @escaping (_ cityName: String?) -> Void) {
        completion("Tauranga")
    }
}
