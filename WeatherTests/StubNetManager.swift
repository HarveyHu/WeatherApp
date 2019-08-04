//
//  StubNetManager.swift
//  WeatherTests
//
//  Created by SwipedOn on 4/08/19.
//  Copyright © 2019 Harvey. All rights reserved.
//

import UIKit
@testable import Weather

class StubNetManager: NetManager {
    override func fetchCurrentWeather(cityId: Int, completion: @escaping (_ currentWeather: CurrentWeather?) -> Void) {
        let jsonString = "{\"coord\":{\"lon\":145.77,\"lat\":-16.92},\"weather\":[{\"id\":802,\"main\":\"Clouds\",\"description\":\"scattered clouds\",\"icon\":\"03n\"}],\"base\":\"stations\",\"main\":{\"temp\":300.15,\"pressure\":1007,\"humidity\":74,\"temp_min\":300.15,\"temp_max\":300.15},\"visibility\":10000,\"wind\":{\"speed\":3.6,\"deg\":160},\"clouds\":{\"all\":40},\"dt\":1485790200,\"sys\":{\"type\":1,\"id\":8166,\"message\":0.2064,\"country\":\"AU\",\"sunrise\":1485720272,\"sunset\":1485766550},\"id\":2172797,\"name\":\"Cairns\",\"cod\":200}"
        let data = jsonString.data(using: .utf8)!
        do {
            let jsonData = try JSONDecoder().decode(CurrentWeather.self, from: data)
            completion(jsonData)
        } catch {
            print(error)
        }
    }
    
    override func fetchForecast(cityId: Int, completion: @escaping (_ currentWeather: Forecast?) -> Void) {
        let jsonString = "{\"cod\":\"200\",\"message\":0.0036,\"cnt\":40,\"list\":[{\"dt\":1485799200,\"main\":{\"temp\":261.45,\"temp_min\":259.086,\"temp_max\":261.45,\"pressure\":1023.48,\"sea_level\":1045.39,\"grnd_level\":1023.48,\"humidity\":79,\"temp_kf\":2.37},\"weather\":[{\"id\":800,\"main\":\"Clear\",\"description\":\"clear sky\",\"icon\":\"02n\"}],\"clouds\":{\"all\":8},\"wind\":{\"speed\":4.77,\"deg\":232.505},\"snow\":{},\"sys\":{\"pod\":\"n\"},\"dt_txt\":\"2017-01-30 18:00:00\"},{\"dt\":1485810000,\"main\":{\"temp\":261.41,\"temp_min\":259.638,\"temp_max\":261.41,\"pressure\":1022.41,\"sea_level\":1044.35,\"grnd_level\":1022.41,\"humidity\":76,\"temp_kf\":1.78},\"weather\":[{\"id\":800,\"main\":\"Clear\",\"description\":\"clear sky\",\"icon\":\"01n\"}],\"clouds\":{\"all\":32},\"wind\":{\"speed\":4.76,\"deg\":240.503},\"snow\":{\"3h\":0.011},\"sys\":{\"pod\":\"n\"},\"dt_txt\":\"2017-01-30 21:00:00\"},{\"dt\":1485820800,\"main\":{\"temp\":261.76,\"temp_min\":260.571,\"temp_max\":261.76,\"pressure\":1021.34,\"sea_level\":1043.21,\"grnd_level\":1021.34,\"humidity\":84,\"temp_kf\":1.18},\"weather\":[{\"id\":800,\"main\":\"Clear\",\"description\":\"clear sky\",\"icon\":\"01d\"}],\"clouds\":{\"all\":76},\"wind\":{\"speed\":2.32,\"deg\":175.001},\"snow\":{\"3h\":0.0049999999999999},\"sys\":{\"pod\":\"d\"},\"dt_txt\":\"2017-02-04 12:00:00\"},{\"dt\":1486220400,\"main\":{\"temp\":260.26,\"temp_min\":260.26,\"temp_max\":260.26,\"pressure\":1021,\"sea_level\":1042.96,\"grnd_level\":1021,\"humidity\":86,\"temp_kf\":0},\"weather\":[{\"id\":803,\"main\":\"Clouds\",\"description\":\"broken clouds\",\"icon\":\"04n\"}],\"clouds\":{\"all\":56},\"wind\":{\"speed\":2.47,\"deg\":180.501},\"snow\":{},\"sys\":{\"pod\":\"n\"},\"dt_txt\":\"2017-02-04 15:00:00\"}],\"city\":{\"id\":524901,\"name\":\"Moscow\",\"coord\":{\"lat\":55.7522,\"lon\":37.6156},\"country\":\"none\"}}"
        let data = jsonString.data(using: .utf8)!
        do {
            let jsonData = try JSONDecoder().decode(Forecast.self, from: data)
            completion(jsonData)
        } catch {
            print(error)
        }
    }
    
    override func fetchWeatherIcon(imageName: String, completion: @escaping (_ weatherIcon: UIImage?) -> Void) {
        completion(nil)
    }
}
