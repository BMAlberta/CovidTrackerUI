//
//  CasesDetailResponseModels.swift
//  Covid-19 Tracker
//
//  Created by Brian Alberta on 4/19/20.
//  Copyright © 2020 Brian Alberta. All rights reserved.
//

import Foundation
import SwiftUI

struct CaseDetailsResponse: Decodable {
    let features: [CaseDetailFeatures]
}

struct CaseDetailFeatures: Decodable {
    let attributes: CaseDetailAttributes
}

struct CaseDetailAttributes: Decodable {
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
    let incidentRate: Double?
    let tested: Int?
    let hospitalized: Int?
    let mortalityRate: Double?
    let hospitalizationRate: Double?
    let testingRate: Double?

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
        case incidentRate = "Incident_Rate"
        case tested = "People_Tested"
        case hospitalized = "People_Hospitalized"
        case mortalityRate = "Mortality_Rate"
        case hospitalizationRate = "Hospitalization_Rate"
        case testingRate = "Testing_Rate"
    }
    
    init() {
        id = nil
        province = nil
        region = nil
        lastUpdate = nil
        latitude = nil
        longitude = nil
        confirmed = nil
        recovered = nil
        deaths = nil
        active = nil
        admin2 = nil
        FIPS = nil
        combinedKey = nil
        incidentRate = nil
        tested = nil
        hospitalized = nil
        mortalityRate = nil
        hospitalizationRate = nil
        testingRate = nil
    }
}
