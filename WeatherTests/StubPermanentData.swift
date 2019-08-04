//
//  StubPermanentData.swift
//  WeatherTests
//
//  Created by SwipedOn on 4/08/19.
//  Copyright © 2019 Harvey. All rights reserved.
//

import Foundation
@testable import Weather

class StubPermanentData: PermanentData {
    // func
    override func loadAllCityList(completion: @escaping () -> Void) {
        completion()
    }
    
    override func getCityId(fromName name: String) -> Int? {
        // Tauranga
        return 2208032
    }
    
    override var favoriteCities: Array<LocalCity>? {
        get {
            return [LocalCity(id: 10, name: "Auckland", country: "NZ", coord: LocalCoord(lat: 10.0, lon: 100.0))]
        }
        set {
        }
    }
    
    override var allCities: Array<LocalCity>? {
        get {
            return [LocalCity(id: 10, name: "Auckland", country: "NZ", coord: LocalCoord(lat: 10.0, lon: 100.0)), LocalCity(id: 10, name: "Tauranga", country: "NZ", coord: LocalCoord(lat: 20.0, lon: 100.0))]
        }
        set {
        }
    }
}
