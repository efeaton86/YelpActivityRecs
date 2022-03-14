//
//  BusinessRow.swift
//  YelpActivityRecs
//
//  Created by Eric Eaton on 3/14/22.
//

import SwiftUI

struct BusinessRow: View {
    @ObservedObject var business: Business
    
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                //image
                let uiImage = UIImage(data: business.imageData ?? Data())
                Image(uiImage: uiImage ?? UIImage())
                    .resizable()
                    .scaledToFit()
                    .frame(width:58, height: 58)
                    .cornerRadius(5)
                
                //name and distance
                VStack(alignment: .leading) {
                    Text(business.name ?? "")
                        .bold()
                    Text(String(format: "%.1f km away", business.distance ?? 0))
                        .font(.caption)
                    
                }
                Spacer()
                //start rating and number of reviews
                VStack(alignment: .leading) {
                    Image("regular_\(business.rating ?? 0)")
                    Text("\(business.reviewCount ?? 0) Reviews")
                        .font(.caption)
                    
                }
            }
            Divider()
        }
        .foregroundColor(.black)
    }
}


