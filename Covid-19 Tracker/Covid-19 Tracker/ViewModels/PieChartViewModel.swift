//
//  PieChartViewModel.swift
//  Covid-19 Tracker
//
//  Created by Brian Alberta on 4/21/20.
//  Copyright © 2020 Brian Alberta. All rights reserved.
//

import Foundation
import SwiftUI
import Combine

class PieChartViewModel: ObservableObject {
    @Published var confirmedCases: Int = 0
    @Published var recoveredCases: Int = 0
    @Published var deaths: Int = 0
    @Published var hospitalized: Int = 0
    
    init(data: StateCurrentDetails) {
        self.confirmedCases = data.positive
        self.recoveredCases = data.recovered ?? 0
        self.deaths = data.death ?? 0
        self.hospitalized = data.hospitalized ?? 0
    }
}
