//
//  CurrentWeather.swift
//  Weather
//
//  Created by HarveyHu on 3/08/19.
//  Copyright © 2019 Harvey. All rights reserved.
//

import Foundation

struct CurrentWeather : Codable {
    
    let coor: Coord?
    let weather: [Weather]?
    let base: String?
    let main: Main?
    let wind: Wind?
    let clouds: Cloud?
    let dt: Int?
    let sys: Sys?
    let id: Int?
    let name: String?
    let cod: Int?
    
    
    enum CodingKeys: String, CodingKey {
        case coor = "coor"
        case weather = "weather"
        case base = "base"
        case main = "main"
        case wind = "wind"
        case clouds = "clouds"
        case dt = "dt"
        case sys = "sys"
        case id = "id"
        case name = "name"
        case cod = "cod"
    }
    
}
