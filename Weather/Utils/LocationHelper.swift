//
//  LocationHelper.swift
//  Weather
//
//  Created by HarveyHu on 31/07/19.
//  Copyright © 2019 Harvey. All rights reserved.
//

import Foundation
import CoreLocation

class LocationHelper: NSObject, CLLocationManagerDelegate {
    let locationManager = CLLocationManager()
    var location: CLLocation?
    var completion: ((String?) -> Void)?
    
    func getCurrentCityName(completion: @escaping (_ cityName: String?) -> Void) {
        self.completion = completion
        locationManager.delegate = self
        locationManager.distanceFilter = kCLDistanceFilterNone
        locationManager.desiredAccuracy = kCLLocationAccuracyThreeKilometers
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }

    // MARK: - CLLocationManagerDelegate
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let geocoder = CLGeocoder()
        location = locations[0]
        if let currentLoc = location {
            geocoder.reverseGeocodeLocation(currentLoc) {[weak self] (placemarks, error) in
                if let placemarks = placemarks, placemarks.count > 0 {
                    let placemark = placemarks[0]
                    print(placemark.locality ?? "")
                    self?.completion?(placemark.locality)
                    self?.locationManager.stopUpdatingLocation()
                }
            }
        }
    }
}
