//
//  SearchResult.swift
//  AppStore
//
//  Created by Mitul Manish on 30/3/19.
//  Copyright © 2019 Mitul Manish. All rights reserved.
//

import Foundation

struct SearchResult: Decodable {
    let resultCount: Int
    let results: [SearchResultItem]
}

struct SearchResultItem: Decodable {
    let primaryGenreName: String
    let trackName: String
    let averageUserRating: Float?
    let screenshotUrls: [String]
    let artworkUrl100: String
    
    var artworkURL: URL? {
        return URL(string: artworkUrl100)
    }
    
    var screenShotURLList: [URL] {
        return screenshotUrls.compactMap { URL(string: $0) }
    }
}
