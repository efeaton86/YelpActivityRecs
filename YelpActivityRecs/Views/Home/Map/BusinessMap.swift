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
        // mapView asks the delegate which view to show and also notifies when a tap occurs
        mapView.delegate = context.coordinator
        
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
    
    // MARK: - Coordinator Class
    func makeCoordinator() -> Coordinator {
        return Coordinator()
    }
    
    class Coordinator: NSObject, MKMapViewDelegate {
        
        func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
            // no need to return annotation view for user location, so return nil
            if annotation is MKUserLocation {
                return nil
            }
            
            // check if there is a reusable annotation view
            var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: Constants.annotationReuseID)
            
            // if there is not a annotaionView that can be reused - create a new one
            if annotationView == nil {
                annotationView = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: Constants.annotationReuseID)
                annotationView!.canShowCallout = true
                annotationView!.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
            }
            // there is annotation that can be reused
            else {
                annotationView!.annotation = annotation
            }
            return annotationView
        }
    }
}
