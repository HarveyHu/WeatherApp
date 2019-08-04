//
//  ForecastViewModel.swift
//  Weather
//
//  Created by HarveyHu on 4/08/19.
//  Copyright © 2019 Harvey. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources

class ForecastViewModel {
    private let disposeBag = DisposeBag()
    let permanentData: PermanentData
    let locationHelper: LocationHelper
    let netManager: NetManager
    var items = PublishSubject<[SectionModel<String, List>]>()
    
    init(permanentData: PermanentData, locationHelper: LocationHelper, netManager: NetManager) {
        self.permanentData = permanentData
        self.locationHelper = locationHelper
        self.netManager = netManager
    }
    
    func updateForecast(cityId: Int) {
        self.netManager.fetchForecast(cityId: cityId) {[weak self] (forecast) in
            if let list = forecast?.list {
                self?.items.onNext([SectionModel(model: "1", items: list)])
            }
        }
    }
    
    func getLocalizedTempUnit() -> TempUnit {
        let locale = NSLocale.current as NSLocale
        if let temperatureUnit = locale.object(forKey: NSLocale.Key(rawValue: "kCFLocaleTemperatureUnitKey")) as? String {
            print(temperatureUnit)
            if temperatureUnit == "Fahrenheit" {
                return TempUnit.f
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
}
