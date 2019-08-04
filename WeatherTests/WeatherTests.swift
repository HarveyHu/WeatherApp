//
//  WeatherTests.swift
//  WeatherTests
//
//  Created by HarveyHu on 30/07/19.
//  Copyright © 2019 Harvey. All rights reserved.
//

import XCTest
@testable import Weather

class WeatherTests: XCTestCase {
    var mainViewModel: MainViewModel?
    
    override func setUp() {
        self.mainViewModel = MainViewModel(permanentData: StubPermanentData(), locationHelper: StubLocationHelper(), netManager: StubNetManager())
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testLocalizedTempUnit() {
        var unit = TempUnit.f
        
        let locale = NSLocale.current as NSLocale
        if let temperatureUnit = locale.object(forKey: NSLocale.Key(rawValue: "kCFLocaleTemperatureUnitKey")) as? String {
            print(temperatureUnit)
            if temperatureUnit == "Fahrenheit" {
                unit = TempUnit.f
            } else {
                unit = TempUnit.c
            }
        }
        
        XCTAssertEqual(unit, self.mainViewModel?.getLocalizedTempUnit())
    }
    
    func testLocalizedTemp() {
        let unit = self.mainViewModel?.getLocalizedTempUnit()
        if unit == TempUnit.c {
            XCTAssertEqual(self.mainViewModel?.getLocalizedTemp(temp: 273.15), 0)
        } else if unit == TempUnit.f {
            XCTAssertEqual(self.mainViewModel?.getLocalizedTemp(temp: 273.15), 32)
        }
    }
    
    func testWindDirection() {
        XCTAssertEqual(self.mainViewModel?.getWindDirection(degree: 0), "N")
        XCTAssertEqual(self.mainViewModel?.getWindDirection(degree: 30), "NE")
        XCTAssertEqual(self.mainViewModel?.getWindDirection(degree: 70), "E")
        XCTAssertEqual(self.mainViewModel?.getWindDirection(degree: 120), "SE")
        XCTAssertEqual(self.mainViewModel?.getWindDirection(degree: 160), "S")
        XCTAssertEqual(self.mainViewModel?.getWindDirection(degree: 210), "SW")
        XCTAssertEqual(self.mainViewModel?.getWindDirection(degree: 250), "W")
        XCTAssertEqual(self.mainViewModel?.getWindDirection(degree: 300), "NW")
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
