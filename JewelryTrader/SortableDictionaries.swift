//
//  SortableDictionaries.swift
//  JewelryTrader
//
//  Created by Daniel Slupskiy on 29.11.16.
//  Copyright © 2016 Daniel Slupskiy. All rights reserved.
//

import Foundation

extension Dictionary {
    func sortedKeys(isOrderedBefore:(Key,Key) -> Bool) -> [Key] {
        return Array(self.keys).sort(isOrderedBefore)
    }
    
    func keysSortedByValue(isOrderedBefore:(Value, Value) -> Bool) -> [Key] {
        return Array(self)
            .sort() {
                let (_, lv) = $0
                let (_, rv) = $1
                return isOrderedBefore(lv, rv)
            }
            .map {
                let (k, _) = $0
                return k
        }
    }
    func keysStringArray() -> [String] {
        return Array(self).map {
            let (k, _) = $0
            return k as! String
        }
    }
    func valuesDoubleArray() -> [Double] {
        return Array(self).map {
            let (_, v) = $0
            if(v is Int){
                return Double(v as! Int)
            }
            return v as! Double
        }
    }

}
