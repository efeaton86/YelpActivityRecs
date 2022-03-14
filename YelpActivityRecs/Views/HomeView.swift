//
//  HomeView.swift
//  YelpActivityRecs
//
//  Created by Eric Eaton on 3/14/22.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var model: ContentModel
    
    @State var isMapViewSelected = false
    
    var body: some View {
        
        if model.restaurants.count != 0 || model.sights.count != 0 {
            NavigationView {
                if !isMapViewSelected {
                    // show list view
                    VStack(alignment: .leading) {
                        HStack {
                            Image(systemName: "location")
                            Text("San Francisco")
                            Spacer()
                            Text("Switch to Map View")
                        }
                        Divider()
                        BusinessList()
                    }
                    .padding([.horizontal, .top])
                    .navigationBarHidden(true)
                }
                else {
                    // show map
                }
            }
        }
        else {
            ProgressView()
        }
        
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
