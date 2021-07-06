//
//  CaseOverviewViewModel.swift
//  Covid-19 Tracker
//
//  Created by Brian Alberta on 4/20/20.
//  Copyright © 2020 Brian Alberta. All rights reserved.
//

import Foundation
import SwiftUI
import Combine

class CaseOverviewViewModel: ObservableObject {
    typealias SortedDetails = [String: [StateCurrentDetails]]
    @Published var loading = false
    @Published var data = [StateCurrentDetails]()
    @Published var selectedRegion: String
    @Published var groupedData = SortedDetails()
    
    private var subscriptions = Set<AnyCancellable>()
    
    init() {
        self.selectedRegion = "US"
        fetchInitialData()
        
    }
    
    deinit {
        subscriptions.removeAll()
    }
    
    func groupData(data: [StateCurrentDetails]) -> SortedDetails {
        
        var tempDict = SortedDetails()
        
        for item in data {
            let prefix = item.state.rawValue.prefix(1)
            tempDict[String(prefix)]?.append(item)
            if let _ = tempDict[String(prefix)] {
                tempDict[String(prefix)]?.append(item)
            } else {
                tempDict[String(prefix)] = [item]
            }
        }
        return tempDict
    }
    
//    func fetchInitialData() {
//        DataManager.fetchOverview(forFilter: .region, queryParam: "US")
//            .sink { (raw: [CaseFeatures]) in
//                let unsorted = raw.map { $0.attributes }
//                self.data = unsorted.sorted { $0.combinedKey ?? "" < $1.combinedKey ?? "" }
//        }
//        .store(in: &subscriptions)
//    }
    
        func fetchInitialData() {
            DataManager.fetchAllStatesCurrentDetails()
                .sink { (raw: [StateCurrentDetails]) in
                    let unsorted = raw.map { $0 }
                    self.data = unsorted.sorted { $0.state.stateName < $1.state.stateName }
                    self.groupedData = self.groupData(data: self.data)
            }
            .store(in: &subscriptions)
        }
}
