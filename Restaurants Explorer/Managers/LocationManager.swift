//
//  LocationManager.swift
//  Restaurants Explorer
//
//  Created by Volodymyr Yatskanych on 06.01.2021.
//

import Foundation
import CoreLocation

final class LocationManager: NSObject, CLLocationManagerDelegate {
    
    //MARK: - Properties

    static let shared = LocationManager()
    let locationManager = CLLocationManager()
    var latitude: CLLocationDegrees?
    var longitude: CLLocationDegrees?
    
    //MARK: - Functions

    func setLocation() {
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            if location.horizontalAccuracy > 0 {
                self.locationManager.stopUpdatingLocation()
                self.latitude = location.coordinate.latitude
                self.longitude = location.coordinate.longitude
            }
        }
    }
    
    func getLocation(result: @escaping(CLLocationDegrees?, CLLocationDegrees?) -> Void) {
        result(self.latitude, self.longitude)
        
    }
    
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
}
