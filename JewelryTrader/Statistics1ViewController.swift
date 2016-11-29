//
//  Statistics1ViewController.swift
//  JewelryTrader
//
//  Created by Daniel Slupskiy on 29.11.16.
//  Copyright © 2016 Daniel Slupskiy. All rights reserved.
//

import UIKit

class Statistics1ViewController: UIViewController {

    @IBOutlet weak var output: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var displayResults = productTypesPopularityPerMonth(basedOnSales: Sale.getAllSales())
        print(displayResults)
        var outputString = "Результаты: \n"
        for key in displayResults.keys {
            outputString += "Месяц № \(key)\n"
            for month in displayResults[key]! {
                outputString += "   ->\(month)\n"
            }
        }
        output.text = outputString
    }

    func productTypesPopularityPerMonth(basedOnSales sales:[Sale]) -> [Int:[String]]{
        var data = [Int:[String:Int]]()
        var result = [Int:[String]]()
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
        for key in data.keys {
            result[key] = data[key]!.keysSortedByValue(>)
        }
        return result
    }
}

