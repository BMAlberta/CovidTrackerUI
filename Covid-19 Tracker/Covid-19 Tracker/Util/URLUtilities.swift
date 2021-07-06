//
//  URLUtilities.swift
//  Covid-19 Tracker
//
//  Created by Brian Alberta on 4/19/20.
//  Copyright © 2020 Brian Alberta. All rights reserved.
//

import Foundation

struct CovidURLs: Decodable {
    let urls: [URLMapping]
}

struct URLMapping: Decodable {
    let urlType: String
    let base: String
}

enum URLType:String, Decodable {
    case overview = "casesOverview"
    case detail = "casesDetail"
    case currentAllStates
    case currentStateBase
    case dailyAllStates
    case dailyStateBase
    case infoAllStates
    case infoStateBase
    case currentUS
    case dailyUS
}


class Configuration {
    
    var urlConfiguration: CovidURLs?
    

    init() {
        urlConfiguration = Configuration.loadURLs()
    }
    
    static func loadURLs() -> CovidURLs? {
        guard let path = Bundle.main.path(forResource: "URLMapping", ofType: "plist") else {
            return nil
        }
        let pathURL = URL(fileURLWithPath: path)
        do {
            
            let data = try Data(contentsOf: pathURL)
            let decoder = PropertyListDecoder()
            let config = try decoder.decode(CovidURLs.self, from: data)
            return config
        } catch {
            print(error)
            return nil
        }
    }
    
    func urlString(for type: URLType) -> String? {
        let urls = self.urlConfiguration?.urls.filter { $0.urlType == type.rawValue }
        return urls?.first?.base
    }
    
    
}
