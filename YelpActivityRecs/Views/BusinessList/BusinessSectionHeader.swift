//
//  BusinessSectionHeader.swift
//  YelpActivityRecs
//
//  Created by Eric Eaton on 3/14/22.
//

import SwiftUI

struct BusinessSectionHeader: View {
    var title: String
    
    var body: some View {
        ZStack(alignment: .leading) {
            Rectangle()
                .foregroundColor(.white)
            Text(title)
                .font(.headline)
        }
    }
}

