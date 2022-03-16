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
            OnboardingView()
        case .authorizedAlways:
            HomeView()
        case .authorizedWhenInUse:
            HomeView()
        case .denied:
            LocationDeniedView()
        default:
            OnboardingView()
        }
    }

}

struct LaunchView_Previews: PreviewProvider {
    static var previews: some View {
        LaunchView()
    }
}
