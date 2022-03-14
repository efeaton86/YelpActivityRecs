//
//  LaunchView.swift
//  YelpActivityRecs
//
//  Created by Eric Eaton on 3/13/22.
//

import SwiftUI
import CoreLocation

struct LaunchView: View {
    // detect authorization status for geolocating
    @EnvironmentObject var model: ContentModel
    
    var body: some View {
        
        switch model.authorizationState {
        case .notDetermined:
            HomeView()
        case .authorizedAlways:
            HomeView()
        case .authorizedWhenInUse:
            HomeView()
        default:
            HomeView()
        }

//        switch model.authorizationState {
//        case .notDetermined:
//            HomeView()
//        case CLAuthorizationStatus.authorizedAlways || CLAuthorizationStatus.authorizedWhenInUse:
//            HomeView()
//        default:
//            HomeView()
            
        // if undetermined, show onboarding
        
        //if approved show home view
        
        // if denied show denied view
    }

}

struct LaunchView_Previews: PreviewProvider {
    static var previews: some View {
        LaunchView()
    }
}
