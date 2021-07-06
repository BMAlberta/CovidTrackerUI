//
//  CaseDetailView.swift
//  Covid-19 Tracker
//
//  Created by Brian Alberta on 4/18/20.
//  Copyright © 2020 Brian Alberta. All rights reserved.
//

import SwiftUI

struct CaseDetailView: View {
    @ObservedObject var viewModel: CaseDetailViewModel
    
    var body: some View {
        
        ActivityIndicatorView(isDisplayed: $viewModel.loading) {
            VStack {
                DetailPieChartView(viewModel: PieChartViewModel(data: self.viewModel.data))
                HStack {
                    Text("Region:")
                        .font(.headline)
                    Spacer()
                    Text("\(self.viewModel.data.state.stateName )")
                        .fontWeight(.thin)
                }
                HStack {
                    Text("Confirmed Cases: ")
                        .font(.subheadline)
                    Spacer()
                    Text("\(self.viewModel.data.positive )")
                        .fontWeight(.bold)
                        .foregroundColor(.red)
                }
                HStack {
                    Text("Deaths: ")
                        .font(.subheadline)
                    Spacer()
                    Text("\(self.viewModel.data.death ?? 0)")
                        .fontWeight(.thin)
                        .foregroundColor(.red)
                }
                HStack {
                    Text("People Tested: ")
                        .font(.subheadline)
                    Spacer()
                    Text("\(self.viewModel.data.totalTestResults)")
                        .fontWeight(.thin)
                        .foregroundColor(.primary)
                }
                HStack {
                    Text("Hospitalized")
                        .font(.subheadline)
                    Spacer()
                    Text("\(self.viewModel.data.hospitalized ?? 0)")
                        .fontWeight(.thin)
                        .foregroundColor(.blue)
                }
            }.padding(EdgeInsets(top: 0, leading: 16.0, bottom: 0, trailing: 16.0))
        }.onAppear(perform: log)
    }
    
    func log() {
        print("View is loading.")
    }
}
