//
//  CasesOverviewListView.swift
//  Covid-19 Tracker
//
//  Created by Brian Alberta on 4/17/20.
//  Copyright © 2020 Brian Alberta. All rights reserved.
//

import SwiftUI
import MapKit
import Combine

struct CasesOverviewListView: View {
    @ObservedObject var viewModel: CaseOverviewViewModel
    
    var body: some View {
        NavigationView{
            List(viewModel.data){ i in
                NavigationLink(destination: LazyView(CaseDetailView(viewModel: CaseDetailViewModel(details: i))) ) {
                    ListItemView(data: i)
                }
            }.navigationBarTitle("Covid Cases Overview")
        }
    }
}

struct ListItemView: View {
    let data: StateCurrentDetails
    
    var body: some View {
        VStack {
            HStack {
                Text("Region:")
                    .font(.headline)
                Spacer()
                Text("\(data.state.stateName)")
                    .fontWeight(.thin)
            }
            HStack {
                Text("Confirmed Cases: ")
                    .font(.subheadline)
                Spacer()
                Text("\(data.positive)")
                    .fontWeight(.bold)
                    .foregroundColor(.red)
            }
            HStack {
                Text("Deaths: ")
                    .font(.subheadline)
                Spacer()
                Text("\(data.death ?? 0)")
                    .fontWeight(.thin)
                    .foregroundColor(.red)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        CasesOverviewListView(viewModel: CaseOverviewViewModel())
    }
}
