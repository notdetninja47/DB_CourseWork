//
//  ProductViewController.swift
//  JewelryTrader
//
//  Created by Daniel Slupskiy on 28.11.16.
//  Copyright © 2016 Daniel Slupskiy. All rights reserved.
//

import UIKit

class ProductViewController: UIViewController {
    
    var entity: Product?

    @IBAction func cancel(sender: UIBarButtonItem) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    @IBAction func save(sender: AnyObject) {
        if saveEntity() {
            dismissViewControllerAnimated(true, completion: nil)
        }
    }
    @IBOutlet weak var skuTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var productTypeTextField: UITextField!
    @IBOutlet weak var supplyDatePicker: UIDatePicker!
    @IBOutlet weak var providerTextField: UITextField!
    @IBOutlet weak var incomePriceTextField: UITextField!
    @IBOutlet weak var weightTextField: UITextField!
    @IBOutlet weak var sizeTextField: UITextField!
    @IBOutlet weak var metalTypeTextField: UITextField!
    @IBOutlet weak var metalContent: UITextField!
    @IBOutlet weak var colorTextField: UITextField!
    @IBOutlet weak var insertionsTextField: UITextField!
    @IBOutlet weak var photosTextField: UITextField!
    @IBOutlet weak var priceTextField: UITextField!
    @IBOutlet weak var isPriceCalculatableSwitch: UISwitch!
    
    @IBAction func isPriceCalculatableChanged(sender: UISwitch) {
        if isPriceCalculatableSwitch.on {
            priceTextField.enabled = false
            entity!.weight = Float(weightTextField.text!)!
            priceTextField.text = String(entity!.automaticallyRecountPrice())
        } else {
            priceTextField.enabled = true
        }
    }
    @IBAction func selectProductType(sender: UIButton) {
        performSegueWithIdentifier("productToProductTypes", sender: nil)
    }
    @IBAction func selectProvider(sender: UIButton) {
        performSegueWithIdentifier("productToProviders", sender: nil)
    }
    @IBAction func selectMetalType(sender: UIButton) {
        performSegueWithIdentifier("productToMetals", sender: nil)
    }
    @IBAction func selectMetalContent(sender: UIButton) {
        performSegueWithIdentifier("productToMetalContents", sender: nil)
    }
    @IBAction func selectColors(sender: UIButton) {
        performSegueWithIdentifier("productToColors", sender: nil)
    }
    @IBAction func selectInsertions(sender: UIButton) {
        performSegueWithIdentifier("productToInsertions", sender: nil)
    }
    @IBAction func selectPhotos(sender: AnyObject) {
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        switch segue.identifier! {
        case "productToProductTypes":
            let controller = segue.destinationViewController.childViewControllers[0] as! ProductTypesTableViewController
            controller.didSelect = {[unowned self] (productType) in
                if let productType = productType {
                    self.entity?.type = productType
                    self.productTypeTextField.text = productType.name
                }
            }
        case "productToMetals":
            let controller = segue.destinationViewController.childViewControllers[0] as! MetalTypeTableViewController
            controller.didSelect = {[unowned self] (metalType) in
                if let metalType = metalType {
                    self.entity?.metalType = metalType
                    self.metalTypeTextField.text = metalType.name
                }
            }
        case "productToMetalContents":
            let controller = segue.destinationViewController.childViewControllers[0] as! MetalContentTableViewController
            controller.didSelect = {[unowned self] (metalContent) in
                if let metalContent = metalContent {
                    self.entity?.metalContent = metalContent
                    self.metalContent.text = metalContent.name
                }
            }
        case "productToColors":
            let controller = segue.destinationViewController.childViewControllers[0] as! ColorTableViewController
            controller.didSelect = {[unowned self] (color) in
                if let color = color {
                    self.entity?.color = color
                    self.colorTextField.text = color.name
                }
            }
        case "productToProviders":
            let controller = segue.destinationViewController.childViewControllers[0] as! ProvidersTableViewController
            controller.didSelect = {[unowned self] (provider) in
                if let provider = provider {
                    self.entity?.provider = provider
                    self.providerTextField.text = provider.name
                }
            }
        case "productToInsertions":
            let controller = segue.destinationViewController.childViewControllers[0] as! InsertionsTableViewController
            controller.product = entity
        default:
            break;
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if entity == nil {
            entity = Product()
            isPriceCalculatableSwitch.on = false
            
            
        } else if let entity = entity {
            skuTextField.text = entity.sku
            nameTextField.text = entity.name
            productTypeTextField.text = entity.type!.name
            supplyDatePicker.date = NSDate(timeIntervalSince1970: entity.supplyDate)
            providerTextField.text = entity.provider?.name
            incomePriceTextField.text = String(entity.incomePrice)
            weightTextField.text = String(entity.weight)
            sizeTextField.text = String(entity.size)
            metalContent.text = entity.metalContent?.name
            metalTypeTextField.text = entity.metalType?.name
            isPriceCalculatableSwitch.on = entity.isPriceCalculatable
            priceTextField.text = String(entity.price)
            priceTextField.enabled = !isPriceCalculatableSwitch.on
            colorTextField.text = entity.color?.name
        }
    }
    override func viewWillAppear(animated: Bool) {
        insertionsTextField.text = "Количество : \(entity!.insertions!.count)"
        if isPriceCalculatableSwitch.on {
            priceTextField.text = String(entity!.automaticallyRecountPrice())
        }
    }
    
    func saveEntity() -> Bool {
        // Validation of required fields
        if skuTextField.text!.isEmpty {
            let alert = UIAlertController(title: "Validation error", message: "Input the sku of the Product!", preferredStyle: .Alert)
            alert.addAction(UIAlertAction(title: "OK", style: .Cancel, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
            return false
        } else if nameTextField.text!.isEmpty {
            let alert = UIAlertController(title: "Validation error", message: "Input the name of the Product!", preferredStyle: .Alert)
            alert.addAction(UIAlertAction(title: "OK", style: .Cancel, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
            return false
        } else if incomePriceTextField.text!.isEmpty {
            let alert = UIAlertController(title: "Validation error", message: "Input the income price of the Product!", preferredStyle: .Alert)
            alert.addAction(UIAlertAction(title: "OK", style: .Cancel, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
            return false
        } else if weightTextField.text!.isEmpty {
            let alert = UIAlertController(title: "Validation error", message: "Input the weight of the Product!", preferredStyle: .Alert)
            alert.addAction(UIAlertAction(title: "OK", style: .Cancel, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
            return false
        } else if sizeTextField.text!.isEmpty {
            let alert = UIAlertController(title: "Validation error", message: "Input the size of the Product!", preferredStyle: .Alert)
            alert.addAction(UIAlertAction(title: "OK", style: .Cancel, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
            return false
        }else if productTypeTextField.text!.isEmpty {
            let alert = UIAlertController(title: "Validation error", message: "Input the type of the Product!", preferredStyle: .Alert)
            alert.addAction(UIAlertAction(title: "OK", style: .Cancel, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
            return false
        }else if metalTypeTextField.text!.isEmpty {
            let alert = UIAlertController(title: "Validation error", message: "Input the metal of the Product!", preferredStyle: .Alert)
            alert.addAction(UIAlertAction(title: "OK", style: .Cancel, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
            return false
        }else if metalContent.text!.isEmpty {
            let alert = UIAlertController(title: "Validation error", message: "Input the metal content of the Product!", preferredStyle: .Alert)
            alert.addAction(UIAlertAction(title: "OK", style: .Cancel, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
            return false
        }else if colorTextField.text!.isEmpty {
            let alert = UIAlertController(title: "Validation error", message: "Input the color of the Product!", preferredStyle: .Alert)
            alert.addAction(UIAlertAction(title: "OK", style: .Cancel, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
            return false
        }else if providerTextField.text!.isEmpty {
            let alert = UIAlertController(title: "Validation error", message: "Input the provider of the Product!", preferredStyle: .Alert)
            alert.addAction(UIAlertAction(title: "OK", style: .Cancel, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
            return false
        }else if priceTextField.text!.isEmpty {
            let alert = UIAlertController(title: "Validation error", message: "Input the price of the Product!", preferredStyle: .Alert)
            alert.addAction(UIAlertAction(title: "OK", style: .Cancel, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
            return false
        }
        
        // Saving object
        if let entity = entity {
            entity.sku = skuTextField.text!
            entity.name = nameTextField.text!
            entity.supplyDate = supplyDatePicker.date.timeIntervalSince1970
            entity.incomePrice = Float(incomePriceTextField.text!)!
            entity.weight = Float(weightTextField.text!)!
            entity.size = Float(sizeTextField.text!)!
            entity.isPriceCalculatable = isPriceCalculatableSwitch.on
            entity.price = Float(priceTextField.text!)!
            
            CoreDataManager.instance.saveContext()
        }
        return true
    }

}
