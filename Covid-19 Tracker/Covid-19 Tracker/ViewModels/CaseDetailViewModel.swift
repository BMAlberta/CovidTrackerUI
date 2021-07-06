//
//  CaseDetailViewModel.swift
//  Covid-19 Tracker
//
//  Created by Brian Alberta on 4/19/20.
//  Copyright © 2020 Brian Alberta. All rights reserved.
//

import Foundation
import SwiftUI
import Combine

class CaseDetailViewModel: ObservableObject {
    
    @Published var loading = false
    @Published var data = StateCurrentDetails()
    
    
    private var subscriptions = Set<AnyCancellable>()
    
    init(details: StateCurrentDetails) {
//        fetchData(forProvince: province)
        self.data = details
    }
    
    deinit {
        subscriptions.removeAll()
    }

    
//    func fetchData(forProvince province: String?) {
//        loading = true
//        let options = DataFilter.QueryType.locale(region: nil, province: province)
//        DataManager.fetchDetails(options: [options])
//            .receive(on: DispatchQueue.main)
//            .sink(receiveCompletion: { (completion) in
//                switch completion {
//                case .finished:
//                    self.loading = false
//                case .failure(let error):
//                    self.loading = false
//                    print("Error: \(error)")
//                }
//            }, receiveValue: { (data: [CaseDetailFeatures]) in
//                guard let attributes = data.first?.attributes else {
//                    return
//                }
//                print("Found details for: \(String(describing: province))")
//                self.data = attributes
//            }).store(in: &subscriptions)
//    }
}

struct LazyView<Content: View>: View {
    let build: () -> Content
    init(_ build: @autoclosure @escaping () -> Content) {
        self.build = build
    }
    var body: Content {
        build()
    }
}
