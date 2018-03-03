//
//  LocationService.swift
//  LocallySourced
//
//  Created by C4Q on 3/3/18.
//  Copyright © 2018 TeamLocallySourced. All rights reserved.
//

import Foundation
import Foundation
import CoreLocation
import MapKit
protocol LocationDelegate: class {
    func userAllowedLocation(with location: CLLocation)
    func userDeniedLocation()
    
}

// This class will create a singlton of the loacationservice which is highly recomended from apple
class LocationService: NSObject {
    static let manager = LocationService()
    private var locationManager: CLLocationManager!
    private var geoCOder = CLGeocoder()
    weak var delegate: LocationDelegate?
    
    private override init() {
        super.init()
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.startUpdatingLocation()
        locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation
    }
    
    
}

//MARK: -  Location Status function
extension LocationService{
    public func checkForLocationServices()->CLAuthorizationStatus{
        let status = CLLocationManager.authorizationStatus()
        if CLLocationManager.locationServicesEnabled() {
            switch CLLocationManager.authorizationStatus() {
            case .notDetermined: // intial state on first launch
                print("not determined")
                locationManager.requestWhenInUseAuthorization()
            case .denied: // user could potentially deny access
                print("denied")
            case .authorizedAlways:
                print("authorizedAlways")
            case .authorizedWhenInUse:
                print("authorizedWhenInUse")
            default:
                break
            }
        }
        return status
    }
}

//MARK: CLLoaction MnagerDelegates
extension LocationService: CLLocationManagerDelegate{
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("didUpdateLocations: \(locations)")
        
        guard let location = locations.last else { print("no location data"); return }
        
        // update user preferences
        delegate?.userAllowedLocation(with: location)
        UserPreference.manager.setLatitude(latitude: location.coordinate.latitude)
        UserPreference.manager.setLongitude(longitude: location.coordinate.longitude)
        locationManager.stopUpdatingLocation()
        
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("didFailWithError: \(error)")
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        print("Dev: Testing didChangeAuthorization: \(status.rawValue)") // e.g .denied, .notDetermined
        
        switch status {
        case .authorizedAlways:
            print("Dev: User authorized location Usage as always")
            break
        case .authorizedWhenInUse:
            print("Dev: User authorized location Usage as when in use")
            break
        case .denied:
            delegate?.userDeniedLocation()
            print("Dev: User denied location Usage")
            break
        case .notDetermined:
            break
        case .restricted:
            break
            
        }
    }
}

//Mark: GeoCoder Methods
extension LocationService {
    func getCityNameFromCLLocation(inputCLLocation: CLLocation, completion: @escaping (String)->Void) {
        DispatchQueue.main.async {
            self.geoCOder.reverseGeocodeLocation(inputCLLocation) { (placeMarks, error) in
                if let error = error{
                    print(error)
                }
                guard let place = placeMarks?.first else{
                    print("DEV: error getting places from the CLLocation")
                    return
                }
                // to get the city name use this
                
                guard let locality = place.locality else { return }
                
                completion(locality)
            }
        }
    }
    
    func getCityCordinateFromCityName(inputCityName: String, completion: @escaping (CLLocation)->Void, errorHandler:@escaping (Error)->Void){
        self.geoCOder.geocodeAddressString(inputCityName) { (placeMarks, error) in
            if let error = error{
                print(error)
                errorHandler(error)
            }
            guard let place = placeMarks?.first else{
                print("DEV: error getting places from the CLLocation")
                
                return
            }
            completion(place.location!)
        }
    }
}

enum UserKeys: String {
    case currentLatitudeKey = "Current Latitude Key"
    case currentLongitudeKey = "Current Longitude Key"
    case currentAddressKey = "Current Address Key"
}

class UserPreference {
    private init(){}
    static let manager = UserPreference()
}

// MARK: Save to defaults functions
extension UserPreference {
    // this function will save a latitude which is a double to the UserDefaults
    public func setLatitude(latitude: Double) {
        UserDefaults.standard.set(latitude, forKey: UserKeys.currentLatitudeKey.rawValue)
    }
    // this function will save a longitude which is a double to the UserDefaults
    public func setLongitude(longitude: Double) {
        UserDefaults.standard.set(longitude, forKey: UserKeys.currentLongitudeKey.rawValue)
    }
    // this function will save a address which is a string to the UserDefaults
    public func setAddress(address: String) {
        UserDefaults.standard.set(address, forKey: UserKeys.currentAddressKey.rawValue)
    }
}

// MARK:- load from defaults function
extension UserPreference {
    // this function will load the latitude from user defaults
    func getLatitude() -> Double {
        guard let latitude = UserDefaults.standard.object(forKey: UserKeys.currentLatitudeKey.rawValue) as? Double else { print("no stored latitude"); return 0.0 }
        return latitude
    }
    // this function will load the longitude from user defaults
    func getLongitude() -> Double {
        guard let longitude = UserDefaults.standard.object(forKey: UserKeys.currentLongitudeKey.rawValue) as? Double else { print("no stored longitude"); return 0.0 }
        return longitude
    }
    // this function will load the address from user defaults
    func getAddress() -> String {
        guard let address = UserDefaults.standard.object(forKey: UserKeys.currentAddressKey.rawValue) as? String else { print("no address found"); return "Queens, NY" }
        return address
    }
}


