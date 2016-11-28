//
//  InsertionViewController.swift
//  JewelryTrader
//
//  Created by Daniel Slupskiy on 28.11.16.
//  Copyright © 2016 Daniel Slupskiy. All rights reserved.
//

import UIKit

class InsertionViewController: UIViewController {
    
    var entity: Insertion?

    @IBAction func cancel(sender: UIBarButtonItem) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    @IBAction func save(sender: AnyObject) {
        if saveEntity() {
            dismissViewControllerAnimated(true, completion: nil)
        }
    }
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var weightTextField: UITextField!
    @IBOutlet weak var priceTextField: UITextField!
    @IBOutlet weak var insertionTypeTextField: UITextField!
    @IBOutlet weak var isValuableSwitch: UISwitch!
    
    @IBAction func isValuableSwitchChanged(sender: AnyObject) {
        if !isValuableSwitch.on {
            priceTextField.text = "0.0"
        }
        priceTextField.enabled = isValuableSwitch.on
    }
    @IBAction func selectInsertionType(sender: UIButton) {
        performSegueWithIdentifier("insertionToInsertionTypes", sender: nil)
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let controller = segue.destinationViewController.childViewControllers[0] as! InsertionTypeTableViewController
        controller.didSelect = {[unowned self] (insertionType) in
            if let insertionType = insertionType {
                self.entity?.type = insertionType
                self.insertionTypeTextField.text = insertionType.name
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let entity = entity {
            nameTextField.text = entity.name
            weightTextField.text = String(entity.weight)
            priceTextField.text = String(entity.price)
            insertionTypeTextField.text = entity.type?.name ?? ""
            isValuableSwitch.on = entity.isValuable
            priceTextField.enabled = entity.isValuable
        }
    }
    
    func saveEntity() -> Bool {
        // Validation of required fields
        if nameTextField.text!.isEmpty {
            let alert = UIAlertController(title: "Validation error", message: "Input the name of the Insertion!", preferredStyle: .Alert)
            alert.addAction(UIAlertAction(title: "OK", style: .Cancel, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
            return false
        } else if priceTextField.text!.isEmpty {
            let alert = UIAlertController(title: "Validation error", message: "Input the price of the Insertion!", preferredStyle: .Alert)
            alert.addAction(UIAlertAction(title: "OK", style: .Cancel, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
            return false
        } else if weightTextField.text!.isEmpty {
            let alert = UIAlertController(title: "Validation error", message: "Input the weight of the Insertion!", preferredStyle: .Alert)
            alert.addAction(UIAlertAction(title: "OK", style: .Cancel, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
            return false
        } else if insertionTypeTextField.text!.isEmpty {
            let alert = UIAlertController(title: "Validation error", message: "Input the type of the Insertion!", preferredStyle: .Alert)
            alert.addAction(UIAlertAction(title: "OK", style: .Cancel, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
            return false
        }
        // Saving object
        if let entity = entity {
            entity.name = nameTextField.text
            entity.isValuable = isValuableSwitch.on
            entity.price = Float(priceTextField.text!)!
            entity.weight = Float(weightTextField.text!)!
            
            CoreDataManager.instance.saveContext()
        }
        return true
    }

}
