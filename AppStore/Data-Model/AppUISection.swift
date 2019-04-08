//
//  AppUISection.swift
//  AppStore
//
//  Created by Mitul Manish on 8/4/19.
//  Copyright © 2019 Mitul Manish. All rights reserved.
//

enum AppGroupSection: CaseIterable {
    case newGames
    case newApps
    case topFree
    case topGrossing
    case topPaid
    case topFreeiPad
    case topGrossingiPad
    
    var urlString: String {
        switch self {
        case .newGames:
            return "https://rss.itunes.apple.com/api/v1/us/ios-apps/new-games-we-love/all/10/explicit.json"
        case .newApps:
            return "https://rss.itunes.apple.com/api/v1/us/ios-apps/new-apps-we-love/all/10/explicit.json"
        case .topFree:
            return "https://rss.itunes.apple.com/api/v1/us/ios-apps/top-free/all/10/explicit.json"
        case .topGrossing:
            return "https://rss.itunes.apple.com/api/v1/us/ios-apps/top-grossing/all/10/explicit.json"
        case .topPaid:
            return "https://rss.itunes.apple.com/api/v1/us/ios-apps/top-paid/all/10/explicit.json"
        case .topFreeiPad:
            return "https://rss.itunes.apple.com/api/v1/us/ios-apps/top-free-ipad/all/10/explicit.json"
        case .topGrossingiPad:
            return "https://rss.itunes.apple.com/api/v1/us/ios-apps/top-grossing-ipad/all/10/explicit.json"
        }
    }
}

enum AppHeader {
    case socialHeader
    
    var urlString: String {
        switch self {
        case .socialHeader:
            return "https://api.letsbuildthatapp.com/appstore/social"
        }
    }
}
