//
//  TableViewController.swift
//  JewelryTrader
//
//  Created by Daniel Slupskiy on 29.11.16.
//  Copyright © 2016 Daniel Slupskiy. All rights reserved.
//

import UIKit

class ProductFilterViewController: UITableViewController {

    var productsTable: ProductsTableViewController?
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var minPrice: UITextField!
    @IBOutlet weak var maxPrice: UITextField!
    @IBOutlet weak var sortingView: UISegmentedControl!
    
    @IBOutlet weak var productTypeTextField: UITextField!
    @IBAction func selectProductType(sender: UIButton) {
        performSegueWithIdentifier("filterToProductTypes", sender: nil)
    }
    @IBAction func clearProductType(sender: AnyObject) {
        productTypeTextField.text = ""
        productType = nil
    }
    var productType:ProductType?
    
    @IBOutlet weak var metalTypeTextField: UITextField!
    @IBAction func selectMetalType(sender: UIButton) {
        performSegueWithIdentifier("filterToMetalTypes", sender: nil)
    }
    @IBAction func clearMetalType(sender: AnyObject) {
        metalTypeTextField.text = ""
        metalType = nil
    }
    var metalType:MetalType?
    
    @IBOutlet weak var colorTextField: UITextField!
    @IBAction func selectColor(sender: UIButton) {
        performSegueWithIdentifier("filterToColors", sender: nil)
    }
    @IBAction func clearColor(sender: AnyObject) {
        colorTextField.text = ""
        color = nil
    }
    var color:Color?
    
    @IBOutlet weak var onlyAvailable: UISwitch!
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        switch segue.identifier! {
        case "filterToProductTypes":
            let controller = segue.destinationViewController as! ProductTypesTableViewController
            controller.didSelect = {[unowned self] (productType) in
                if let productType = productType {
                    self.productType = productType
                    self.productTypeTextField.text = productType.name
                }
            }
        case "filterToMetalTypes":
            let controller = segue.destinationViewController as! MetalTypeTableViewController
            controller.didSelect = {[unowned self] (metalType) in
                if let metalType = metalType {
                    self.metalType = metalType
                    self.metalTypeTextField.text = metalType.name
                }
            }
        case "filterToColors":
            let controller = segue.destinationViewController as! ColorTableViewController
            controller.didSelect = {[unowned self] (color) in
                if let color = color {
                    self.color = color
                    self.colorTextField.text = color.name
                }
            }
        default: break
        }
    }
    
    
    @IBAction func applyChanges(sender: UIButton) {
        let productFilter = ProductFilter()
        productFilter.color = color
        productFilter.maxPrice = Float(maxPrice.text!)
        productFilter.metalType = metalType
        productFilter.minPrice = Float(minPrice.text!)
        productFilter.nameSearch = nameTextField.text
        productFilter.onlyAvailable = onlyAvailable.on
        productFilter.productType = productType
        productFilter.sortKey = sortingView.selectedSegmentIndex == 0 ? "name" : "sku"
        productsTable!.productFilterState = productFilter
        dismissViewControllerAnimated(true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        let productFilter = productsTable!.productFilterState!
        color = productFilter.color
        colorTextField.text = productFilter.color?.name
        maxPrice.text = String(_cocoaString: (productFilter.maxPrice ?? ""))
        minPrice.text = String(_cocoaString: (productFilter.minPrice ?? ""))
        metalType = productFilter.metalType
        metalTypeTextField.text = productFilter.metalType?.name
        nameTextField.text = String(_cocoaString: (productFilter.nameSearch ?? ""))
        onlyAvailable.on = productFilter.onlyAvailable
        productType = productFilter.productType
        productTypeTextField.text = productFilter.productType?.name
        sortingView.selectedSegmentIndex = (productFilter.sortKey == "name" ? 0 : 1)
    }
}
