//
//  PieChartView.swift
//  Covid-19 Tracker
//
//  Created by Brian Alberta on 4/21/20.
//  Copyright © 2020 Brian Alberta. All rights reserved.
//

import SwiftUI
import Charts

struct DetailPieChartView: UIViewRepresentable {
    @ObservedObject var viewModel: PieChartViewModel
    
    func makeUIView(context: UIViewRepresentableContext<DetailPieChartView>) -> PieChartView {
        let view = PieChartView()
        view.maxAngle = 180 // Half chart
        view.rotationAngle = 180
        setDataCount(chartView: view)
        return view
    }
    
    func updateUIView(_ uiView: PieChartView, context: Context) {
        
    }
    
    func setDataCount(chartView: PieChartView) {
        
        let entries: [PieChartDataEntry] = [PieChartDataEntry(value: Double(viewModel.confirmedCases)),
        PieChartDataEntry(value: Double(viewModel.hospitalized)),
        PieChartDataEntry(value: Double(viewModel.deaths)),
        PieChartDataEntry(value: Double(viewModel.recoveredCases))]
        
        
        let set = PieChartDataSet(entries: entries, label: "Case Breakdown")
        set.sliceSpace = 3
        set.selectionShift = 5
        set.colors = ChartColorTemplates.material()
        
        let data = PieChartData(dataSet: set)
        
        let pFormatter = NumberFormatter()
        pFormatter.numberStyle = .none
        pFormatter.multiplier = 1
        data.setValueFormatter(DefaultValueFormatter(formatter: pFormatter))
    
        data.setValueFont(UIFont(name: "HelveticaNeue-Light", size: 11)!)
        data.setValueTextColor(.white)
        
        chartView.data = data
        chartView.drawEntryLabelsEnabled = false
        
        chartView.setNeedsDisplay()
    }
    
    func makeCoordinator() -> DetailPieChartCoordinator {
        DetailPieChartCoordinator()
    }
}
