//
//  SaleViewController.swift
//  JewelryTrader
//
//  Created by Daniel Slupskiy on 28.11.16.
//  Copyright © 2016 Daniel Slupskiy. All rights reserved.
//

import UIKit

class SaleViewController: UIViewController {
    
    var entity: Sale?

    @IBAction func cancel(sender: UIBarButtonItem) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    @IBAction func save(sender: AnyObject) {
        if saveEntity() {
            dismissViewControllerAnimated(true, completion: nil)
        }
    }
    
    @IBOutlet weak var productTextField: UITextField!
    @IBOutlet weak var customerTextField: UITextField!
    @IBOutlet weak var dateTextField: UITextField!
    @IBOutlet weak var amountTextField: UITextField!
    @IBOutlet weak var profit: UITextField!
    
    @IBAction func selectProduct(sender: UIButton) {
        performSegueWithIdentifier("saleToProducts", sender: nil)
    }
    
    @IBAction func selectCustomer(sender: UIButton) {
        performSegueWithIdentifier("saleToCustomers", sender: nil)
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        switch segue.identifier! {
        case "saleToProducts":
            let controller = segue.destinationViewController.childViewControllers[0] as! ProductsTableViewController
            controller.didSelect = {[unowned self] (product) in
                if let product = product {
                    self.entity?.product = product
                    self.productTextField.text = product.name
                }
            }
        case "saleToCustomers":
            let controller = segue.destinationViewController.childViewControllers[0] as! CustomersTableViewController
            controller.didSelect = {[unowned self] (customer) in
                if let customer = customer {
                    self.entity?.customer = customer
                    self.customerTextField.text = customer.fullName
                }
            }
        default:
            break;
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if entity == nil {
            entity = Sale()
            entity!.date = NSDate().timeIntervalSince1970
            dateTextField.text = NSDate(timeIntervalSince1970: entity!.date).description
        } else if let entity = entity {
            productTextField.text = entity.product!.name
            customerTextField.text = entity.customer!.fullName
            dateTextField.text = NSDate(timeIntervalSince1970: entity.date).description
            amountTextField.text = String(entity.amount)
            productTextField.text = String(entity.profit)
        }
    }
    override func viewWillAppear(animated: Bool) {
        if entity?.product != nil {
            amountTextField.text = String(entity!.product!.price)
            profit.text = String(entity!.product!.price - entity!.product!.incomePrice)
        }
    }
    
    func saveEntity() -> Bool {
        // Validation of required fields
        if productTextField.text!.isEmpty {
            let alert = UIAlertController(title: "Validation error", message: "Input the product of the Sale!", preferredStyle: .Alert)
            alert.addAction(UIAlertAction(title: "OK", style: .Cancel, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
            return false
        } else if customerTextField.text!.isEmpty {
            let alert = UIAlertController(title: "Validation error", message: "Input the customer of the Sale!", preferredStyle: .Alert)
            alert.addAction(UIAlertAction(title: "OK", style: .Cancel, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
            return false
        }
        // Saving object
        if let entity = entity {
            entity.amount = Float(amountTextField.text!)!
            entity.profit = Float(profit.text!)!
            
            CoreDataManager.instance.saveContext()
        }
        return true
    }

}
