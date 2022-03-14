//
//  BusinessSection.swift
//  YelpActivityRecs
//
//  Created by Eric Eaton on 3/14/22.
//

import SwiftUI

struct BusinessSection: View {
    var title: String
    var businesses: [Business]
    
    var body: some View {
        Section(header: BusinessSectionHeader(title: title)) {
            ForEach(businesses) { business in
                
                NavigationLink(destination: BusinessDetailView(business: business)) {
                    BusinessRow(business: business)
                }
               
               
           }
        }
    }
}

