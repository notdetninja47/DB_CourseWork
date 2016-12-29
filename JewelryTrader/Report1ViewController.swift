//
//  Report1ViewController.swift
//  JewelryTrader
//
//  Created by Daniel Slupskiy on 29.12.16.
//  Copyright © 2016 Daniel Slupskiy. All rights reserved.
//

import UIKit

class Report1ViewController: ViewController {

    var sale: Sale?
    var pdfDestination:String?
    
    
    @IBOutlet weak var headerLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var buyerNameLabel: UILabel!
    @IBOutlet weak var buyerPhoneLabel: UILabel!
    @IBOutlet weak var buyerEmailLabel: UILabel!
    @IBOutlet weak var skuLabel: UILabel!
    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var productPriceLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var dateString = NSDate(timeIntervalSince1970: sale!.date).description
        dateString = dateString.substringToIndex(dateString.endIndex.advancedBy(-5))
        dateLabel.text = dateLabel.text!+" \(dateString)"
        buyerNameLabel.text = buyerNameLabel.text!+" \(sale!.customer!.fullName!)"
        buyerPhoneLabel.text = buyerPhoneLabel.text!+" \(sale!.customer!.phone!)"
        buyerEmailLabel.text = buyerEmailLabel.text!+" \(sale!.customer!.mail!)"
        skuLabel.text = skuLabel.text!+" \(sale!.product!.sku!)"
        productNameLabel.text = productNameLabel.text!+" \(sale!.product!.name!)"
        productPriceLabel.text = productPriceLabel.text!+" \(sale!.product!.price)"
        
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
}
