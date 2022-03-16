//
//  LocationDeniedView.swift
//  YelpActivityRecs
//
//  Created by Eric Eaton on 3/15/22.
//

import SwiftUI

struct LocationDeniedView: View {
    let backgroundColor = Color(red: 34/255, green: 141/255, blue: 138/255)
    
    var body: some View {
        VStack {
            Spacer()
            Text("Whoops")
                .font(.title)
                .foregroundColor(.white)
            Text("We need to access your location to provide you with the best sights in the city. You can change your decision at any time in Settings")
                .foregroundColor(.white)
            Spacer()
            
            Button {
                // open settings
                if let url = URL(string: UIApplication.openSettingsURLString) {
                    if UIApplication.shared.canOpenURL(url) {
                        // if we can open the setting url, open it
                        UIApplication.shared.open(url, options: [:], completionHandler: nil)
                    }
                }
            } label: {
                ZStack {
                    Rectangle()
                        .foregroundColor(.white)
                        .frame(height: 48)
                        .cornerRadius(10)
                    Text("Go to Settings")
                        .bold()
                        .foregroundColor(backgroundColor)}
                        .padding()
            }
            Spacer()
        }
        .multilineTextAlignment(.center)
        .background(backgroundColor)
        .ignoresSafeArea(.all, edges: .all)
        
    }
}

struct LocationDeniedView_Previews: PreviewProvider {
    static var previews: some View {
        LocationDeniedView()
    }
}
