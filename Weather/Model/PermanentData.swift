//
//  PermanentData.swift
//  Weather
//
//  Created by HarveyHu on 30/07/19.
//  Copyright © 2019 Harvey. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class PermanentData {
    // func
    func loadAllCityList(completion: @escaping () -> Void) {
        if self.allCities != nil && self.allCities!.count != 0 {
            completion()
            return
        }
        DispatchQueue.global().async {
            if let path = Bundle.main.path(forResource: "city.list", ofType: "json") {
                do {
                    let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                    let decoder = JSONDecoder()
                    let jsonData = try decoder.decode([LocalCity].self, from: data)
                    
                    //let allCities = jsonData.filter({ $0.country == "NZ" })
                    self.allCities = jsonData
                    
                    DispatchQueue.main.async {
                        completion()
                    }
                    
                    
                } catch {
                    print("error:\(error)")
                }
            }
        }
    }
    
    func getCityId(fromName name: String) -> Int? {
        if let allCities = PermanentData().allCities, let index = allCities.firstIndex(where: { $0.name == name }) {
            print("The first index = \(index)")
            print("jsonData:\(allCities[index])")
            return allCities[index].id
        }
        return nil
    }
    
    var favoriteCities: Array<LocalCity>? {
        get {
            if let data = getData(key: Constant.KEY_FAVORITE_CITIES) {
                let decodedCities = NSKeyedUnarchiver.unarchiveObject(with: data) as? [LocalCity]
                
                return decodedCities
            }
            return nil
        }
        set {
            setObjectAsData(key: Constant.KEY_FAVORITE_CITIES, value: newValue as AnyObject?)
        }
    }
    
    var allCities: Array<LocalCity>? {
        get {
            if let data = getData(key: Constant.KEY_ALL_CITIES) {
                let decodedCities = NSKeyedUnarchiver.unarchiveObject(with: data) as? [LocalCity]
                
                return decodedCities
            }
            return nil
        }
        set {
            setObjectAsData(key: Constant.KEY_ALL_CITIES, value: newValue as AnyObject?)
        }
    }
    
    
    // MARK: - Operation
    func getData(key: String) -> Data? {
        return UserDefaults.standard.object(forKey: key) as? Data
    }
    
    func setObjectAsData(key: String, value: Any?) {
        if let value = value {
            do {
            let data = try NSKeyedArchiver.archivedData(withRootObject: value, requiringSecureCoding: false)
            UserDefaults.standard.set(data, forKey: key)
            } catch {
                print("error:\(error)")
            }
        } else {
            UserDefaults.standard.removeObject(forKey: key)
        }
    }
    
    func getObject(key: String) -> AnyObject? {
        return UserDefaults.standard.object(forKey: key) as AnyObject?
    }
    
    func setObject(key: String, value: AnyObject?) {
        if value == nil {
            UserDefaults.standard.removeObject(forKey: key)
        } else {
            UserDefaults.standard.set(value, forKey: key)
        }
    }
    
    private func getBool(key: String, defaultValue: Bool) -> Bool {
        if getObject(key: key) == nil {
            setObject(key: key, value: defaultValue as AnyObject?)
        }
        return UserDefaults.standard.bool(forKey: key)
    }
    
    private func getString(key: String, defaultValue: String) -> String {
        if let result = getObject(key: key) as? String {
            return result
        }
        setObject(key: key, value: defaultValue as AnyObject?)
        return defaultValue
    }
    
    private func getDictionary(key: String, defaultValue: Dictionary<String, AnyObject>) -> Dictionary<String, AnyObject> {
        if let result = getObject(key: key) as? Dictionary<String, AnyObject> {
            return result
        }
        setObject(key: key, value: defaultValue as AnyObject?)
        return defaultValue
    }
    
    private func getArray(key: String, defaultValue: Array<AnyObject>) -> Array<AnyObject> {
        if let result = getObject(key: key) as? Array<AnyObject> {
            return result
        }
        setObject(key: key, value: defaultValue as AnyObject?)
        return defaultValue
    }
}
