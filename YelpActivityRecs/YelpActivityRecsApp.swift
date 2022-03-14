//
//  YelpActivityRecsApp.swift
//  YelpActivityRecs
//
//  Created by Eric Eaton on 3/13/22.
//

import SwiftUI

@main
struct YelpActivityRecsApp: App {
    var body: some Scene {
        WindowGroup {
            LaunchView()
                .environmentObject(ContentModel())
        }
    }
}
