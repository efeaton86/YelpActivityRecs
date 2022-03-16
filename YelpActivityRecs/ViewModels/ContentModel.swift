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
    @Published var authorizationState = CLAuthorizationStatus.notDetermined
    
    @Published var restaurants = [Business]()
    @Published var sights = [Business]()
    
    @Published var placemark: CLPlacemark?
    
    
    
    // override NSObject initializer
    override init() {
        super.init()
        
        // set content model as delegate of location manager
        locationManager.delegate = self
        
    }
    
    func requestGeolocationPermission() {
        // request permission from user
        locationManager.requestWhenInUseAuthorization()
    }
    
    // MARK: - Location Manager Delegate Methods
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        // update authorizationState proerty
        authorizationState = locationManager.authorizationStatus
        
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
            
            // get the placemark of the user
            let geoCoder = CLGeocoder()
            geoCoder.reverseGeocodeLocation(userLocation) { placemarks, error in
                // check that there are no errors
                if error == nil && placemarks != nil {
                    self.placemark = placemarks?.first
                }
            }
            
            //fetch businesses
            getBusinesses(category: "restaurants", location: userLocation)
            getBusinesses(category: "arts", location: userLocation)
        }
    }
    
    func getBusinesses(category: String, location: CLLocation) {
        // create url object
        var urlComponents = URLComponents(string: Constants.yelpAPIURL)
        urlComponents?.queryItems = [
            URLQueryItem(name: "latitude", value: String(location.coordinate.latitude)),
            URLQueryItem(name: "longitude", value: String(location.coordinate.longitude)),
            URLQueryItem(name: "categories", value: category),
            URLQueryItem(name: "limit", value: String(6))
        ]
        
        if let url = urlComponents?.url {
            var request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10.0)
            request.httpMethod = "GET"
            request.addValue(Constants.yelpAPIKey, forHTTPHeaderField: "Authorization")
            
            let session = URLSession.shared
        
            let dataTask = session.dataTask(with: request) { data, response, error in
                if error == nil {
                    print(response!)
                    //parse json
                    do {
                        let decoder = JSONDecoder()
                        let result = try decoder.decode(BusinessSearch.self, from: data!)
                        
                        // sort businesses
                        var businesses = result.businesses
                        businesses.sorted { b1, b2 in
                            return b1.distance ?? 0 < b2.distance ?? 0
                        }
                        // download business image
                        for b in result.businesses {
                            b.getImageData()
                        }
                        
                        DispatchQueue.main.async {
                            switch category {
                            case Constants.restaurantKey:
                                self.restaurants = businesses
                            case Constants.artsKey:
                                self.sights = businesses
                            default:
                                break
                            }
 
                        }
                    }
                    catch {
                        print(error)
                    }
                    
                }
                if error != nil {
                    print(error!)
                }
            }
            dataTask.resume()
        }
    }
}
