//
//  OverviewInfoViewModel.swift
//  Covid-19 Tracker
//
//  Created by Brian Alberta on 4/23/20.
//  Copyright © 2020 Brian Alberta. All rights reserved.
//

import SwiftUI
import Combine
import Foundation

class OverviewInfoViewModel: ObservableObject {
    @Published var state = false
    @Published var dataPoints = [DataPoint]()
    
    private var subscriptions = Set<AnyCancellable>()
    
    init(data: StateCurrentDetails?) {
    }
    
    deinit {
        subscriptions.removeAll()
    }
}
