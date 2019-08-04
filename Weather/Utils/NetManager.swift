//
//  NetManager.swift
//  Weather
//
//  Created by HarveyHu on 3/08/19.
//  Copyright © 2019 Harvey. All rights reserved.
//

import RxSwift
import Alamofire

struct ServerApi {
    static let urlHost = "https://api.openweathermap.org/data/2.5/"
}

class NetManager {
    func fetchCurrentWeather(cityId: Int, completion: @escaping (_ currentWeather: CurrentWeather?) -> Void) {
        guard let secretKey = SensitiveData().openWeatherSecretKey else {
            print("secretKey doesn't exist")
            return
        }
        
        let path = ServerApi.urlHost + "weather?id=\(cityId)&appid=\(secretKey)"
        if let url = URL(string: path) {
            Alamofire.request(url).response { (response) in
                if let data = response.data {
                    do {
                        let jsonData = try JSONDecoder().decode(CurrentWeather.self, from: data)
                        completion(jsonData)
                    } catch {
                        print(error)
                    }
                    
                }
            }
        }
    }
    
    func fetchForecast(cityId: Int, completion: @escaping (_ currentWeather: Forecast?) -> Void) {
        guard let secretKey = SensitiveData().openWeatherSecretKey else {
            print("secretKey doesn't exist")
            return
        }
        
        let path = ServerApi.urlHost + "forecast?id=\(cityId)&appid=\(secretKey)"
        if let url = URL(string: path) {
            Alamofire.request(url).response { (response) in
                if let data = response.data {
                    do {
                        let jsonData = try JSONDecoder().decode(Forecast.self, from: data)
                        completion(jsonData)
                    } catch {
                        print(error)
                    }
                }
            }
        }
    }
    
    func fetchWeatherIcon(imageName: String, completion: @escaping (_ weatherIcon: UIImage?) -> Void) {
        let path = "https://openweathermap.org/img/wn/\(imageName)@2x.png"
        if let url = URL(string: path) {
            Alamofire.request(url).response { (response) in
                if let data = response.data {
                    let image = UIImage(data: data)
                    completion(image)
                }
            }
        }
    }
}
