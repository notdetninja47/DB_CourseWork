//
//  CustomerViewController.swift
//  JewelryTrader
//
//  Created by Daniel Slupskiy on 28.11.16.
//  Copyright © 2016 Daniel Slupskiy. All rights reserved.
//

import UIKit

class CustomerViewController: UIViewController {
    
    var entity: Customer?

    @IBAction func cancel(sender: UIBarButtonItem) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    @IBAction func save(sender: AnyObject) {
        if saveEntity() {
            dismissViewControllerAnimated(true, completion: nil)
        }
    }
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var mailTextField: UITextField!
    @IBOutlet weak var infoTextField: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Reading object
        if let entity = entity {
            nameTextField.text = entity.fullName
            phoneTextField.text = entity.phone
            mailTextField.text = entity.mail
            infoTextField.text = entity.info
        }
    }
    
    func saveEntity() -> Bool {
        // Validation of required fields
        if nameTextField.text!.isEmpty {
            let alert = UIAlertController(title: "Validation error", message: "Input the name of the Customer!", preferredStyle: .Alert)
            alert.addAction(UIAlertAction(title: "OK", style: .Cancel, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
            return false
        }
        // Creating object
        if entity == nil {
            entity = Customer()
        }
        // Saving object
        if let entity = entity {
            entity.fullName = nameTextField.text
            entity.phone = phoneTextField.text
            entity.mail = mailTextField.text
            entity.info = infoTextField.text
            CoreDataManager.instance.saveContext()
        }
        return true
    }

}
