//
//  StateCurrentDetails.swift
//  Covid-19 Tracker
//
//  Created by Brian Alberta on 4/22/20.
//  Copyright © 2020 Brian Alberta. All rights reserved.
//

import Foundation

struct StateCurrentDetails: Decodable, Identifiable {
    
    var id: String
    let state: USState
    let positive: Int
    let positiveScore: Int?
    let negativeScore: Int?
    let negativeRegularScore: Int?
    let commercialScore: Int?
    let grade: Grade?
    let score: Int?
    let negative: Int
    let pending: Int?
    let hospitalizedCurrently: Int?
    let hospitalizedCumulative: Int?
    let inIcuCurrently: Int?
    let inIcuCumulative: Int?
    let onVentilatorCurrently: Int?
    let onVentilatorCumulative: Int?
    let recovered: Int?
    let lastUpdateEt: String
    let checkTimeEt: String
    let death : Int?
    let hospitalized: Int?
    let total: Int
    let totalTestResults: Int
    let posNeg: Int
    let fips: String
    let dateModified: String
    let dateChecked: String
    let notes: String
//    let hash: String
    
    enum CodingKeys: String, CodingKey {
        
        case state = "state"
        case positive  = "positive"
        case positiveScore = "positiveScore"
        case negativeScore = "negativeScore"
        case negativeRegularScore = "negativeRegularScore"
        case commercialScore = "commercialScore"
        case grade = "grade"
        case score = "score"
        case negative = "negative"
        case pending = "pending"
        case hospitalizedCurrently = "hospitalizedCurrently"
        case hospitalizedCumulative = "hospitalizedCumulative"
        case inIcuCurrently = "inIcuCurrently"
        case inIcuCumulative = "inIcuCumulative"
        case onVentilatorCurrently = "onVentilatorCurrently"
        case onVentilatorCumulative = "onVentilatorCumulative"
        case recovered = "recovered"
        case lastUpdateEt = "lastUpdateEt"
        case checkTimeEt = "checkTimeEt"
        case death = "death"
        case hospitalized = "hospitalized"
        case total = "total"
        case totalTestResults = "totalTestResults"
        case posNeg = "posNeg"
        case fips = "fips"
        case dateModified = "dateModified"
        case dateChecked = "dateChecked"
        case notes = "notes"
        case id = "hash"
    }
    
    init() {
        state = .ALL
        positive = 0
        positiveScore = nil
        negativeScore = nil
        negativeRegularScore = nil
        commercialScore = nil
        grade = .F
        score = nil
        negative = 0
        pending = nil
        hospitalizedCurrently = nil
        hospitalizedCumulative = nil
        inIcuCurrently = nil
        inIcuCumulative = nil
        onVentilatorCurrently = nil
        onVentilatorCumulative = nil
        recovered = nil
        lastUpdateEt = ""
        checkTimeEt = ""
        death = nil
        hospitalized = nil
        total = 0
        totalTestResults = 0
        posNeg = 0
        fips = ""
        dateModified = ""
        dateChecked = ""
        notes = ""
        id = ""
    }
}

enum Grade: String, Decodable {
    case A
    case B
    case C
    case D
    case F
}

