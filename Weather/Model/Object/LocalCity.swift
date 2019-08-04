//
//  LocalCity.swift
//  Weather
//
//  Created by HarveyHu on 2/08/19.
//  Copyright © 2019 Harvey. All rights reserved.
//

import Foundation

class LocalCity : NSObject, Codable, NSCoding {
    func encode(with aCoder: NSCoder) {
        aCoder.encode(id, forKey: "id")
        aCoder.encode(name, forKey: "name")
        aCoder.encode(country, forKey: "country")
        aCoder.encode(coord, forKey: "coord")
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        let id = aDecoder.decodeInteger(forKey: "id")
        let name = aDecoder.decodeObject(forKey: "name") as! String
        let country = aDecoder.decodeObject(forKey: "country") as! String
        let coord = aDecoder.decodeObject(forKey: "coord") as! LocalCoord
        self.init(id: id, name: name, country: country, coord: coord)
    }
    
    init(id: Int, name: String, country: String, coord: LocalCoord) {
        self.id = id
        self.name = name
        self.country = country
        self.coord = coord
        
    }
    
    let coord : LocalCoord
    let country : String
    let id : Int
    let name : String
}

class LocalCoord : NSObject, Codable, NSCoding {
    var lat : Double
    var lon : Double
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(lat, forKey: "lat")
        aCoder.encode(lon, forKey: "lon")
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        let lat = aDecoder.decodeDouble(forKey: "lat")
        let lon = aDecoder.decodeDouble(forKey: "lon")
        self.init(lat: lat, lon: lon)
    }
    
    init(lat: Double, lon: Double) {
        self.lat = lat
        self.lon = lon
        
    }
}
