//
//  SensitiveData.swift
//  Weather
//
//  Created by HarveyHu on 30/07/19.
//  Copyright © 2019 Harvey. All rights reserved.
//

import Foundation
import KeychainAccess

class SensitiveData {
    private var keychain = Keychain(accessGroup: "com.harvey")
    
    var openWeatherSecretKey: String? {
        get {
            do {
                let result = try self.keychain.getString(Constant.KEY_OPEN_WEATHER_SECRET)
                return result
            } catch  {
                return nil
            }
        }
        set {
            self.keychain[Constant.KEY_OPEN_WEATHER_SECRET] = newValue
        }
    }
}
