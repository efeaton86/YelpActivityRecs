//
//  ContentModel.swift
//  YelpActivityRecs
//
//  Created by Eric Eaton on 3/13/22.
//

import Foundation
import CoreLocation

class ContentModel: NSObject, CLLocationManagerDelegate, ObservableObject {
    var locationManager = CLLocationManager()
    
    // override NSObject initializer
    override init() {
        super.init()
        
        // set content model as delegate of location manager
        locationManager.delegate = self
        
        // request permission from user
        locationManager.requestWhenInUseAuthorization()
        
        // detect user response
        
        //Start geolocating
    }
    
    // MARK: - Location Manager Delegate Methods
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        
        if manager.authorizationStatus == .authorizedAlways ||
            manager.authorizationStatus == .authorizedWhenInUse {
            manager.startUpdatingLocation()
        }
        else if manager.authorizationStatus == .denied {
            // don't have permission
            print("no permission")
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        // gives location of user
        print(locations.first ?? "no locations")
        
        if let userLocation = locations.first {
            // if we have a user location, stop updating location
            manager.stopUpdatingLocation()
            
            //fetch businesses
            getBusinesses(category: "restaurants", location: userLocation)
        }
    }
    
    func getBusinesses(category: String, location: CLLocation) {
        // create url object
        var urlComponents = URLComponents(string: "https://api.yelp.com/v3/businesses/search")
        urlComponents?.queryItems = [
            URLQueryItem(name: "latitude", value: String(location.coordinate.latitude)),
            URLQueryItem(name: "longitude", value: String(location.coordinate.longitude)),
            URLQueryItem(name: "categories", value: category),
            URLQueryItem(name: "limit", value: String(6))
        ]
        
        if let url = urlComponents?.url {
            var request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10.0)
            request.httpMethod = "GET"
            request.addValue(yelpAPIKey, forHTTPHeaderField: "Authorization")
            
            let session = URLSession.shared
        
            let dataTask = session.dataTask(with: request) { data, response, error in
                if error == nil {
                    print(response!)
                }
                if error != nil {
                    print(error!)
                }
            }
            dataTask.resume()
        }
    }
}
