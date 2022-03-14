//
//  BusinessSearch.swift
//  YelpActivityRecs
//
//  Created by Eric Eaton on 3/14/22.
//

import Foundation

struct BusinessSearch: Codable {
    var businesses = [Business]()
    var total = 0
    var region = Region()
}

struct Region: Codable {
    var center = Coordinate()
    
}
