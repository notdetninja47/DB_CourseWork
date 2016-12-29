//
//  Report1ViewController.swift
//  JewelryTrader
//
//  Created by Daniel Slupskiy on 29.12.16.
//  Copyright © 2016 Daniel Slupskiy. All rights reserved.
//

import UIKit

class Report2ViewController: ViewController {
    
    var pdfDestination:String?
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var categoriesStats: UILabel!
    @IBOutlet weak var metalStats: UILabel!
    @IBOutlet weak var incomeTotalPrice: UILabel!
    @IBOutlet weak var totalPrice: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var dateString = NSDate().description
        dateString = " " + dateString.substringToIndex(dateString.endIndex.advancedBy(-5))
        dateLabel.text! += dateString
        categoriesStats.text = getCategoriesText()
        metalStats.text = getMetalsText()
        incomeTotalPrice.text = "в закупке \(getIncomeTotalPrice())"
        totalPrice.text = "в продаже \(getTotalPrice())"
        
        do {
            let dst = getDestinationPath(1)
            let data = try PDFGenerator.generate(view)
            data.writeToFile(dst, atomically: true)
            pdfDestination = dst
        } catch (let e) {
            print(e)
        }
    }
    
    func getDestinationPath(number: Int) -> String {
        return NSHomeDirectory().stringByAppendingString("/sample\(number).pdf")
    }
    
    func getCategoriesText() -> String {
        let productTypes = ProductType.getAllTypes()
        var result = ""
        for productType in productTypes {
            var productsCount = 0
            for element in productType.products! {
                let product = element as! Product
                if !product.isSold {
                    productsCount += 1
                }
            }
            
            result += "\(productType.name!) - \(productsCount), "
        }
        result = result.substringToIndex(result.endIndex.predecessor().predecessor())
        return result
    }
    func getMetalsText() -> String {
        let metalTypes = MetalType.getAllTypes()
        var result = ""
        for metalType in metalTypes {
            var weight = 0.0
            
            for element in metalType.products! {
                let product = element as! Product
                
                if !product.isSold {
                    weight += Double(product.weight)
                }
            }
            
            result += "\(metalType.name!) - \(weight), "
        }
        result = result.substringToIndex(result.endIndex.predecessor().predecessor())
        return result
    }
    func getIncomeTotalPrice() -> Double {
        let products = Product.getAllProducts()
        var result = 0.0
        for product in products {
            result += Double(product.incomePrice)
        }
        return result
    }
    func getTotalPrice() -> Double {
        let products = Product.getAllProducts()
        var result = 0.0
        for product in products {
            result += Double(product.price)
        }
        return result
    }
}
