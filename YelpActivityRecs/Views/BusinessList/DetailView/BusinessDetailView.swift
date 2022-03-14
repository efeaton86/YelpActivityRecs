//
//  BusinessDetailView.swift
//  YelpActivityRecs
//
//  Created by Eric Eaton on 3/14/22.
//

import SwiftUI

struct BusinessDetailView: View {
    var business: Business

    var body: some View {
        
        VStack(alignment: .leading) {
            VStack(alignment: .leading, spacing: 0) {
                GeometryReader() { geo in
                    // Business Image
                    let uiImage = UIImage(data: business.imageData ?? Data())
                    Image(uiImage: uiImage ?? UIImage())
                        .resizable()
                        .scaledToFill()
                        .frame(width: geo.size.width, height: geo.size.height)
                        .clipped()
                }
                .ignoresSafeArea(.all, edges: .top)
                
                ZStack(alignment: .leading) {
                    Rectangle()
                        .frame(height: 36)
                        .foregroundColor(business.isClosed! ? .gray : .blue)
                    Text(business.isClosed! ? "Closed" : "Open")
                        .foregroundColor(.white)
                        .bold()
                        .padding(.leading)
                }
            }
            

            
            Group {
                //Business Name
                Text(business.name!)
                    .font(.largeTitle)
                    .padding()
                //Address
                if business.location?.displayAddress != nil {
                    ForEach(business.location!.displayAddress!, id: \.self) { displayAddress in
                        Text(displayAddress)
                            .padding(.horizontal)
                    }
                }
                    
                //Rating
                Image("regular_\(business.rating ?? 0)")
                    .padding(.horizontal)
                
                Divider()
                //Phone
                HStack {
                    Text("Phone:")
                        .bold()
                    Text(business.displayPhone ?? "")
                    Spacer()
                    Link("Call", destination: URL(string: "tel:\(business.phone ?? "")")!)
                }
                .padding()
                Divider()
                //Reviews
                HStack {
                    Text("Reviews:")
                        .bold()
                    Text(String(business.reviewCount ?? 0))
                    Spacer()
                    Link("Read", destination: URL(string: "tel:\(business.url ?? "")")!)
                }
                .padding()
                Divider()
                //Website
                HStack {
                    Text("Website:")
                        .bold()
                    Text(business.url ?? "")
                        .lineLimit(1)
                    Spacer()
                    Link("Visit", destination: URL(string: "tel:\(business.url ?? "")")!)
                }
                .padding()
                Divider()
                
            }
            //Get directions button
            Button {
                //show directions
            } label: {
                ZStack {
                    Rectangle()
                        .frame(height: 48)
                        .foregroundColor(.blue)
                        .cornerRadius(15)
                    Text("Get Directions")
                        .foregroundColor(.white)
                        .bold()
                }
            }
            .padding()
            
        }
    }
}

//struct BusinessDetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        BusinessDetailView()
//    }
//}
