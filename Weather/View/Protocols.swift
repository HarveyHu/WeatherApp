//
//  Protocols.swift
//  Weather
//
//  Created by HarveyHu on 31/07/19.
//  Copyright © 2019 Harvey. All rights reserved.
//

protocol UISetting {
    func setUI()
    func setUIConstraints()
    func setUIEvents()
}

enum TempUnit: String {
    case c = "°C"
    case f = "°F"
}
