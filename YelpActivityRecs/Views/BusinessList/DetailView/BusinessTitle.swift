//
//  BusinessTitle.swift
//  YelpActivityRecs
//
//  Created by Eric Eaton on 3/15/22.
//

import SwiftUI

struct BusinessTitle: View {
    var business: Business
    
    var body: some View {
        VStack(alignment: .leading) {
            //Business Name
            Text(business.name!)
                .font(.title2)
                .bold()
            //Address
            if business.location?.displayAddress != nil {
                ForEach(business.location!.displayAddress!, id: \.self) { displayAddress in
                    Text(displayAddress)
                }
            }
            //Rating
            Image("regular_\(business.rating ?? 0)")
        }

    }
}

