//
//  Statistics1ViewController.swift
//  JewelryTrader
//
//  Created by Daniel Slupskiy on 29.11.16.
//  Copyright © 2016 Daniel Slupskiy. All rights reserved.
//

import UIKit

class Statistics2ViewController: UIViewController {

    @IBOutlet weak var output: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()

        let displayResults = productTypesProfit(basedOnSales: Sale.getAllSales())
        print(displayResults)
        var outputString = "Результаты: \n"
        for (key,value) in displayResults {
            outputString += "\(key) : \(value)\n"
        }
        output.text = outputString
    }
    
    func productTypesProfit(basedOnSales sales:[Sale]) -> [String : Float]{
        var result = [String : Float]()
        
        for sale in sales {
            if result[sale.product!.type!.name!] == nil {
                result[sale.product!.type!.name!] = 0
            }
            result[sale.product!.type!.name!]! += sale.profit
        }
        
        return result
    }

}
