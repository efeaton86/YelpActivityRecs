//
//  BusinessMap.swift
//  YelpActivityRecs
//
//  Created by Eric Eaton on 3/14/22.
//

import SwiftUI
import MapKit

struct BusinessMap: UIViewRepresentable {
    @EnvironmentObject var model: ContentModel
    
    var locations: [MKPointAnnotation] {
        var annotations = [MKPointAnnotation]()
        
        // Create set of annotations from list of businesses
        for business in model.restaurants + model.sights {
            
            // If business has a lat and long - create MKPointAnnotation
            if let lat = business.coordinates?.latitude, let long = business.coordinates?.longitude {
                // create new annotation
                let a = MKPointAnnotation()
                a.coordinate = CLLocationCoordinate2D(latitude: lat, longitude: long)
                a.title = business.name ?? ""
                annotations.append(a)
            }

        }
        return annotations
    }
    
    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView()
        
        // Make user show on map
        mapView.showsUserLocation = true
        mapView.userTrackingMode = .followWithHeading
        
        return mapView
    }
    
    func updateUIView(_ uiView: MKMapView, context: Context) {
        // remove all annotations
        uiView.removeAnnotations(uiView.annotations)
        
        // Add annotations
        uiView.showAnnotations(self.locations, animated: true)
        
    }
    
    static func dismantleUIView(_ uiView: MKMapView, coordinator: ()) {
        
        uiView.removeAnnotation(uiView.annotations as! MKAnnotation)
        
    }
}
