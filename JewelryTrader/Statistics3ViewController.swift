//
//  Statistics1ViewController.swift
//  JewelryTrader
//
//  Created by Daniel Slupskiy on 29.11.16.
//  Copyright © 2016 Daniel Slupskiy. All rights reserved.
//

import UIKit

class Statistics3ViewController: UIViewController {

    
    @IBOutlet weak var barChart: BarChartView!
    override func viewDidLoad() {
        super.viewDidLoad()
        let data = getProvidersAmount()
        print(data)
        setChart(data.keysStringArray(), values: data.valuesDoubleArray())
        barChart.animate(xAxisDuration: 0.5, yAxisDuration: 0.5)
    }
    func getProvidersAmount() -> [String : Double] {
        var result = [String : Double]()
        for product in Product.getAllProducts() {
            if result[product.provider!.name!] == nil {
               result[product.provider!.name!] = 0.0
            }
            if let productSale = product.sale {
                result[product.provider!.name!] = result[product.provider!.name!]! + Double(productSale.profit)
            } else {
                result[product.provider!.name!] = result[product.provider!.name!]! - Double(product.incomePrice)
            }
        }
        return result
    }
    
    func setChart(dataPoints:[String], values:[Double]) {
        var dataEntries: [BarChartDataEntry] = []
        var colors = [UIColor]()
        
        for i in 0..<dataPoints.count {
            let dataEntry = BarChartDataEntry(value: values[i], xIndex: i)
            dataEntries.append(dataEntry)
            
            if (values[i] <= 0)
            {
                colors.append(UIColor.redColor())
            }
            else
            {
                colors.append(UIColor.greenColor())
            }
        }
        
        let chartDataSet = BarChartDataSet(yVals: dataEntries, label: "Эффективность")
        let chartData = BarChartData(xVals: dataPoints, dataSet: chartDataSet)
        
        chartDataSet.colors = colors
        barChart.data = chartData
        barChart.data!.setValueFont(NSUIFont(name: "Helvetica", size: 20))
        let ll = ChartLimitLine(limit: values.minElement()!, label: "Лимит")
        barChart.rightAxis.addLimitLine(ll)
    }
}
