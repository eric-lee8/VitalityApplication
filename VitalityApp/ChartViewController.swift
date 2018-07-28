//
//  ChartViewController.swift
//  VitalityApp
//
//  Created by Jacky Huynh on 2018-07-27.
//  Copyright © 2018 Eric Joseph Lee. All rights reserved.
//

import UIKit
import Charts

class ChartViewController: UIViewController {

    var total_weight = Shared.shared.veg_weight_total + Shared.shared.grain_weight_total + Shared.shared.meat_weight_total
    
    var veg_chart = PieChartDataEntry(value: 0)
    var grain_chart = PieChartDataEntry(value: 0)
    var meat_chart = PieChartDataEntry(value: 0)
    
    var plateData = [PieChartDataEntry]()
 
    @IBOutlet var pieChart: PieChartView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let veg_entry = (Shared.shared.veg_weight_total / total_weight) * 100
        let grain_entry = (Shared.shared.grain_weight_total / total_weight) * 100
        let meat_entry = (Shared.shared.meat_weight_total / total_weight) * 100
        
        veg_chart = PieChartDataEntry(value: veg_entry, label: "Vegetables")
        grain_chart = PieChartDataEntry(value: grain_entry, label: "Whole Grains")
        meat_chart = PieChartDataEntry(value: meat_entry, label: "Meat & Alternatives")
        plateData = [veg_chart, grain_chart, meat_chart]
        updateChartData()
        
        pieChart.chartDescription?.text = ""
        pieChart.translatesAutoresizingMaskIntoConstraints = false
        pieChart.drawHoleEnabled = false
        pieChart.legend.enabled = false
        
    }
    
    func updateChartData() {
        let chartDataSet = PieChartDataSet(values: plateData, label: "Food Groups")
        let chartData = PieChartData(dataSet: chartDataSet)
        
        let colours = [UIColor(named: "veg_colour"), UIColor(named: "grain_colour"), UIColor(named: "meat_colour")]
        
        chartDataSet.colors = colours as! [NSUIColor]
        pieChart.data = chartData
        
    }
    
    
}
