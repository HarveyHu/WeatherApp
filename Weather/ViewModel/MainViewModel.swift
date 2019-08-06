//
//  MainViewModel.swift
//  Weather
//
//  Created by HarveyHu on 31/07/19.
//  Copyright © 2019 Harvey. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources

class MainViewModel {
    private let disposeBag = DisposeBag()
    let permanentData: PermanentData
    let locationHelper: LocationHelper
    let netManager: NetManager
    var items = PublishSubject<[SectionModel<String, LocalCity>]>()
    var cities = [LocalCity]()
    var weatherIcon = PublishSubject<UIImage>()
    var currentWeather = PublishSubject<CurrentWeather>()
    
    init(permanentData: PermanentData, locationHelper: LocationHelper, netManager: NetManager) {
        self.permanentData = permanentData
        self.locationHelper = locationHelper
        self.netManager = netManager
    }
    
    func getLocalizedTempUnit() -> TempUnit {
        let locale = NSLocale.current as NSLocale
        if let temperatureUnit = locale.object(forKey: NSLocale.Key(rawValue: "kCFLocaleTemperatureUnitKey")) as? String {
            print(temperatureUnit)
            if temperatureUnit == "Fahrenheit" {
                return TempUnit.f
            } else {
                return TempUnit.c
            }
        }
        return TempUnit.c
    }
    
    func getLocalizedTemp(temp: Float) -> Float {
        if self.getLocalizedTempUnit() == TempUnit.c {
            return temp - 273.15
        }
        return (temp - 273.15) * 9 / 5 + 32
    }
    
    func getWindDirection(degree: Float) -> String? {
        if degree >= 337.5 || degree < 22.5  { return "N" }
        if degree >= 22.5  && degree < 67.5  { return "NE" }
        if degree >= 67.5  && degree < 112.5 { return "E" }
        if degree >= 112.5 && degree < 157.5 { return "SE" }
        if degree >= 157.5 && degree < 202.5 { return "S" }
        if degree >= 202.5 && degree < 247.5 { return "SW" }
        if degree >= 247.5 && degree < 292.5 { return "W" }
        if degree >= 292.5 && degree < 337.5 { return "NW" }
        return nil
    }
    
    func reloadAllCities() {
        self.permanentData.loadAllCityList {
            print("loadAllCityList complete")
        }
    }
    
    func updateCurrentWeather(cityId: Int) {
        self.netManager.fetchCurrentWeather(cityId: cityId) {[weak self] (currentWeather) in
            if let cWeather = currentWeather {
                self?.currentWeather.onNext(cWeather)
            }
        }
    }
    
    func updateCurrentWeatherByLocation() {
        self.locationHelper.getCurrentCityName {[weak self] (cityName) in
            if let name = cityName {
                if let cityId = self?.permanentData.getCityId(fromName: name) {
                    self?.netManager.fetchCurrentWeather(cityId: cityId) {[weak self] (currentWeather) in
                        if let cWeather = currentWeather {
                            self?.currentWeather.onNext(cWeather)
                        }
                    }
                }
            }
        }
    }
    
    func reloadFavoriteCities() {
        self.items.onNext([SectionModel(model: "1", items: self.permanentData.favoriteCities ?? [LocalCity]())])
    }
    
    func updateWeatherIcon(imageName: String) {
        if let image = UIImage.getCachedImage(imageName: "\(imageName).png") {
            print("exist")
            self.weatherIcon.onNext(image)
        } else {
            self.netManager.fetchWeatherIcon(imageName: "\(imageName)") { (weatherIcon) in
                if let img = weatherIcon {
                    let isCached = UIImage.cacheImage(imageName: "\(imageName).png", image: img)
                    if isCached {
                        self.weatherIcon.onNext(img)
                    }
                }
            }
        }
    }
    
    func addCityToFavorite(cityName: String) {
        if let allCities = self.permanentData.allCities, let index = allCities.firstIndex(where: { $0.name.lowercased() == cityName.lowercased() }) {
            print("The first index = \(index)")
            print("jsonData:\(allCities[index])")
            var favCities = self.permanentData.favoriteCities
            if favCities != nil {
                favCities!.append(allCities[index])
            } else {
                favCities = [allCities[index]]
            }
            self.permanentData.favoriteCities = favCities
            self.items.onNext([SectionModel(model: "1", items: self.permanentData.favoriteCities ?? [LocalCity]())])
        }
    }
}
