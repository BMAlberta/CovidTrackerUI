//
//  OverviewInfoView.swift
//  Covid-19 Tracker
//
//  Created by Brian Alberta on 4/23/20.
//  Copyright © 2020 Brian Alberta. All rights reserved.
//

import SwiftUI

struct OverviewInfoView: View {
    @ObservedObject var viewModel: OverviewInfoViewModel
    
    var body: some View {
        List {
            OverviewDataView()
            OverviewDataView()
            OverviewDataView()
            OverviewDataView()
            OverviewDataView()
        }
    }
}

struct OverviewDataView: View {
    
    var body: some View {
        HStack {
            VStack {
                Text("Confirmed")
                    .font(.system(size: 16, weight: .regular, design: .rounded))
                Text("1,234,567")
                    .font(.system(size: 22, weight: .semibold, design: .rounded))
                    .foregroundColor(.yellow)
            }
            Spacer()
            Divider()
            Spacer()
            VStack {
                Text("Deaths")
                    .font(.system(size: 16, weight: .regular, design: .rounded))
                Text("1,234,567")
                    .font(.system(size: 22, weight: .semibold, design: .rounded))
                    .foregroundColor(.red)
            }
            Spacer()
            Divider()
            Spacer()
            VStack {
                Text("Hospitalized")
                    .font(.system(size: 16, weight: .regular, design: .rounded))
                Text("1,234,567")
                    .font(.system(size: 22, weight: .semibold, design: .rounded))
                    .foregroundColor(.gray)
            }
        }
    }
    
}

struct OverviewInfoView_Previews: PreviewProvider {
    static var previews: some View {
        OverviewInfoView(viewModel: OverviewInfoViewModel(data: nil))
    }
}
