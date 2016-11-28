//
//  MetalContentViewController.swift
//  JewelryTrader
//
//  Created by Daniel Slupskiy on 28.11.16.
//  Copyright © 2016 Daniel Slupskiy. All rights reserved.
//

import UIKit

class MetalContentViewController: UIViewController {
    
    var entity: MetalContent?

    @IBAction func cancel(sender: UIBarButtonItem) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    @IBAction func save(sender: AnyObject) {
        if saveEntity() {
            dismissViewControllerAnimated(true, completion: nil)
        }
    }
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var contentTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Reading object
        if let entity = entity {
            nameTextField.text = entity.name
            contentTextField.text = String(entity.content)
        }
    }
    
    func saveEntity() -> Bool {
        // Validation of required fields
        if nameTextField.text!.isEmpty {
            let alert = UIAlertController(title: "Validation error", message: "Input the name of the Metal Content!", preferredStyle: .Alert)
            alert.addAction(UIAlertAction(title: "OK", style: .Cancel, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
            return false
        }
        if contentTextField.text!.isEmpty {
            let alert = UIAlertController(title: "Validation error", message: "Input the conent of the Metal!", preferredStyle: .Alert)
            alert.addAction(UIAlertAction(title: "OK", style: .Cancel, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
            return false
        }
        // Creating object
        if entity == nil {
            entity = MetalContent()
        }
        // Saving object
        if let entity = entity {
            entity.name = nameTextField.text
            entity.content = Float(contentTextField.text!)!
            CoreDataManager.instance.saveContext()
        }
        return true
    }

}
