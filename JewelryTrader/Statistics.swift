//
//  ProductTypesPopularityPerMonth.swift
//  JewelryTrader
//
//  Created by Daniel Slupskiy on 29.11.16.
//  Copyright © 2016 Daniel Slupskiy. All rights reserved.
//

import Foundation

class Statistics {
    static func productTypesPopularityPerMonth(basedOnSales sales:[Sale]){
        var result = [Int:[String:Int]]()
        var calendar = NSCalendar.currentCalendar()
        
        for sale in sales {
            let date = NSDate(timeIntervalSince1970: sale.date)
            let components = calendar.components(NSCalendarUnit.Month, fromDate: date)
            let typeName = sale.product!.type!.name!
            if result[components.month] == nil {
                result[components.month] = [String:Int]()
            } else if result[components.month]![typeName] == nil{
                result[components.month]![typeName] = 0
            } else {
                result[components.month]![typeName]!+=1
            }
        }
    }
//    static func ProductTypesPopularityPerMonth(){
//        
//    }
//    static func ProductTypesPopularityPerMonth(){
//        
//    }
    
}