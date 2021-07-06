//
//  CasesResponseModels.swift
//  Covid-19 Tracker
//
//  Created by Brian Alberta on 4/18/20.
//  Copyright © 2020 Brian Alberta. All rights reserved.
//

import Foundation

struct CasesRawResponse: Decodable {
    let objectIdFieldName: String
    let uniqueIdField: CasesUniqueField
    let globalIdFieldName: String
    let geometryType: String
    let spatialReference: CasesSpatialReference
    let fields: [CasesFields]
    let features: [CaseFeatures]
}

struct CasesUniqueField: Decodable {
    let name: String
    let isSystemMaintained: Bool
}

struct CasesSpatialReference: Decodable {
    let wkid: Int
    let latestWkid: Int
}

struct CasesFields: Decodable {
    let name: String
    let type: String
    let alias: String
    let sqlType: String
    let domain: String?
    let defaultValue: String?
}

struct CaseFeatures: Decodable {
    let attributes: CasesAttributes
}

struct CasesAttributes: Decodable, Identifiable {
    let id: Int?
    let province: String?
    let region: String?
    let lastUpdate: Int?
    let latitude: Double?
    let longitude: Double?
    let confirmed: Int?
    let recovered: Int?
    let deaths: Int?
    let active: Int?
    let admin2: String?
    let FIPS: String?
    let combinedKey: String?

    enum CodingKeys: String, CodingKey {
        case id = "OBJECTID"
        case province = "Province_State"
        case region = "Country_Region"
        case lastUpdate = "Last_Update"
        case latitude = "Lat"
        case longitude = "Long_"
        case confirmed = "Confirmed"
        case recovered = "Recovered"
        case deaths = "Deaths"
        case active = "Active"
        case admin2 = "Admin2"
        case FIPS
        case combinedKey = "Combined_Key"
    }
}

enum CovidError: Error {
    case statusCode
    case invalidUrl
    case invalidImage
    case other(Error)
    
    static func map(_ error: Error) -> CovidError {
      return (error as? CovidError) ?? .other(error)
    }
}
