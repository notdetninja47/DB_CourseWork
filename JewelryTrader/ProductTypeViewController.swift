//
//  ProductTypeViewController.swift
//  JewelryTrader
//
//  Created by Daniel Slupskiy on 28.11.16.
//  Copyright © 2016 Daniel Slupskiy. All rights reserved.
//

import UIKit

class ProductTypeViewController: UIViewController {
    
    var entity: ProductType?

    @IBAction func cancel(sender: UIBarButtonItem) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    @IBAction func save(sender: AnyObject) {
        if saveEntity() {
            dismissViewControllerAnimated(true, completion: nil)
        }
    }
    @IBOutlet weak var nameTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Reading object
        if let entity = entity {
            nameTextField.text = entity.name
        }
    }
    
    func saveEntity() -> Bool {
        // Validation of required fields
        if nameTextField.text!.isEmpty {
            let alert = UIAlertController(title: "Validation error", message: "Input the name of the Product type!", preferredStyle: .Alert)
            alert.addAction(UIAlertAction(title: "OK", style: .Cancel, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
            return false
        }
        // Creating object
        if entity == nil {
            entity = ProductType()
        }
        // Saving object
        if let entity = entity {
            entity.name = nameTextField.text
            CoreDataManager.instance.saveContext()
        }
        return true
    }

}
