//
//  Statistics1ViewController.swift
//  JewelryTrader
//
//  Created by Daniel Slupskiy on 29.11.16.
//  Copyright © 2016 Daniel Slupskiy. All rights reserved.
//

import UIKit

class Statistics1ViewController: UIViewController {

    @IBOutlet weak var monthSelector: UISegmentedControl!
    @IBOutlet weak var pieChart: PieChartView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pieChart.descriptionText = "Популярность категорий"
        pieChart.usePercentValuesEnabled = true
        
        pieChart.noDataText = "Нет продаж в этом месяце"
        pieChart.legend.enabled = false
        pieChart.infoFont = NSUIFont(name: "Helvetica", size: 20)
        pieChart.infoTextColor = UIColor.darkTextColor()
        pieChart.animate(xAxisDuration: 2.0, yAxisDuration: 2.0, easingOption: ChartEasingOption.EaseInOutBack)
       
        
    }

    @IBAction func mothSelected(sender: AnyObject) {
        showMonth(withNumber: monthSelector.selectedSegmentIndex+1)
    }
    func productTypesPopularityPerMonth(basedOnSales sales:[Sale]) -> [Int:[String:Int]]{
        var data = [Int:[String:Int]]()
        let calendar = NSCalendar.currentCalendar()
        
        for sale in sales {
            let date = NSDate(timeIntervalSince1970: sale.date)
            let components = calendar.components(NSCalendarUnit.Month, fromDate: date)
            let typeName = sale.product!.type!.name!
            if data[components.month] == nil {
                data[components.month] = [String:Int]()
            }
            if data[components.month]![typeName] == nil{
                data[components.month]![typeName] = 1
            } else {
                data[components.month]![typeName]!+=1
            }
        }
        return data
    }
    
    func showMonth(withNumber month:Int) {
        var data = productTypesPopularityPerMonth(basedOnSales: Sale.getAllSales())
        print(data)
     
        if let dataForMonth = data[month] {
            setChart(dataForMonth.keysStringArray(), values: dataForMonth.valuesDoubleArray())
        } else {
            pieChart.data = nil
        }
    }
    
    func setChart(dataPoints: [String], values: [Double]) {
        
        var dataEntries: [ChartDataEntry] = []
        
        for i in 0..<dataPoints.count {
            let dataEntry = ChartDataEntry(value: values[i], xIndex: i)
            dataEntries.append(dataEntry)
        }
        
        let pieChartDataSet = PieChartDataSet(yVals: dataEntries, label: "Продажи")
        let pieChartData = PieChartData(xVals: dataPoints, dataSet: pieChartDataSet)
        pieChart.data = pieChartData
        
        pieChartDataSet.colors = ChartColorTemplates.colorful()
        
        pieChart.data!.setValueFont(NSUIFont(name: "Helvetica", size: 20))
        
    }
}

