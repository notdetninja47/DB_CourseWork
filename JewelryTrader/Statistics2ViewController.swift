//
//  Statistics2ViewController.swift
//  JewelryTrader
//
//  Created by Daniel Slupskiy on 29.12.16.
//  Copyright © 2016 Daniel Slupskiy. All rights reserved.
//

import UIKit

class Statistics2ViewController: ViewController {

    @IBOutlet weak var barChart: BarChartView!
    override func viewDidLoad() {
        super.viewDidLoad()

        let displayResults = productTypesProfit(basedOnSales: Sale.getAllSales())
        print(displayResults)

        barChart.noDataText = "Нет данных для отображения"
        barChart.descriptionText = ""
        
        
        setChart(displayResults.keysStringArray(), values: displayResults.valuesDoubleArray())
        barChart.animate(xAxisDuration: 0.5, yAxisDuration: 0.5)
    }
    
    func productTypesProfit(basedOnSales sales:[Sale]) -> [String : Double] {
        var result = [String : Double]()
        for sale in sales {
            if result[sale.product!.type!.name!] == nil {
                result[sale.product!.type!.name!] = 0
            }
            result[sale.product!.type!.name!] = result[sale.product!.type!.name!]! + Double(sale.profit)
        }
        return result
    }
    
    func setChart(dataPoints:[String], values:[Double]) {
        var dataEntries: [BarChartDataEntry] = []
        
        for i in 0..<dataPoints.count {
            let dataEntry = BarChartDataEntry(value: values[i], xIndex: i)
            dataEntries.append(dataEntry)
        }
        
        let chartDataSet = BarChartDataSet(yVals: dataEntries, label: "Выручка")
        let chartData = BarChartData(xVals: dataPoints, dataSet: chartDataSet)
        
        chartDataSet.colors = ChartColorTemplates.colorful()
        barChart.data = chartData
        barChart.data!.setValueFont(NSUIFont(name: "Helvetica", size: 20))
    }

}
