//
//  DirectionsView.swift
//  YelpActivityRecs
//
//  Created by Eric Eaton on 3/15/22.
//
/*
 https://developer.apple.com/library/archive/featuredarticles/iPhoneURLScheme_Reference/MapLinks/MapLinks.html
 
 Using link below to build directions
 http://maps.apple.com/?ll=50.894967,4.341626
 
 */

import SwiftUI

struct DirectionsView: View {
    var business: Business
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                //business title
                BusinessTitle(business: business)
                Spacer()
                if let lat = business.coordinates?.latitude,
                    let long = business.coordinates?.longitude,
                   let name = business.name {
                    Link("Open in Maps", destination: URL(string: "http://maps.apple.com/?ll=\(lat),\(long)&q=\(name.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!)")!)
                }
                
            }
            .padding()
            //directions map
            DirectionsMap(business: business)
                .ignoresSafeArea(.all, edges: .bottom)
        }
    }
}

//struct DirectionsView_Previews: PreviewProvider {
//    static var previews: some View {
//        DirectionsView()
//    }
//}
