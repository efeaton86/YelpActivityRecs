//
//  DirectionsMap.swift
//  YelpActivityRecs
//
//  Created by Eric Eaton on 3/15/22.
//

import SwiftUI
import MapKit

struct DirectionsMap: UIViewRepresentable {
    // use locationManager from ContentModel to access user location
    @EnvironmentObject var model: ContentModel
    var business: Business
    
    // computed property for start and end point
    var start: CLLocationCoordinate2D {
        return model.locationManager.location?.coordinate ?? CLLocationCoordinate2D()
    }
    
    var end: CLLocationCoordinate2D {
        if let lat = business.coordinates?.latitude, let long = business.coordinates?.longitude {
            return CLLocationCoordinate2D(latitude: lat, longitude: long)
        }
        else {
            return CLLocationCoordinate2D()
        }
    }

    func makeUIView(context: Context) -> MKMapView {
        // create the map to be displayed
        let map = MKMapView()
        map.delegate = context.coordinator
        
        //show user locations
        map.showsUserLocation = true
        map.userTrackingMode = .followWithHeading
        
        // create directions request
        let request = MKDirections.Request()
        request.source = MKMapItem(placemark: MKPlacemark(coordinate: start))
        request.destination = MKMapItem(placemark: MKPlacemark(coordinate: end))
        
        // create directions object
        let directions = MKDirections(request: request)
        
        // calculate the route
        directions.calculate { response, error in
            if error == nil && response != nil {
                for route in response!.routes {
                    // plot out the routes
                    map.addOverlay(route.polyline)
                    
                    // zoom in to region
                    map.setVisibleMapRect(route.polyline.boundingMapRect, edgePadding: UIEdgeInsets(top: 100, left: 100, bottom: 100, right: 100), animated: true)
                }
            }
        }
        //place annotation for end point
        let annotation = MKPointAnnotation()
        annotation.coordinate = end
        annotation.title = business.name ?? ""
        map.addAnnotation(annotation)
        
        return map
    }
    
    func updateUIView(_ uiView: MKMapView, context: Context) {
        
    }
    
    static func dismantleUIView(_ uiView: MKMapView, coordinator: Coordinator) {
        uiView.removeAnnotations(uiView.annotations)
        uiView.removeOverlays(uiView.overlays)
    }
    
    // MARK: - Coordinator
    
    func makeCoordinator() -> Coordinator {
        return Coordinator()
    }
    
    class Coordinator: NSObject, MKMapViewDelegate {
        
        func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
            // this method determines how the polylines (routing) will be drawn on the map
            let renderer = MKPolylineRenderer(polyline: overlay as! MKPolyline)
            renderer.lineWidth = 5
            renderer.strokeColor = .blue
            return renderer
        }
    }
}
