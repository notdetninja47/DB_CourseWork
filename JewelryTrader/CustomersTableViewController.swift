//
//  CustomersTableViewController.swift
//  JewelryTrader
//
//  Created by Daniel Slupskiy on 28.11.16.
//  Copyright © 2016 Daniel Slupskiy. All rights reserved.
//

import UIKit
import CoreData

class CustomersTableViewController: UITableViewController, NSFetchedResultsControllerDelegate {
    
    @IBOutlet weak var addButton: UIBarButtonItem!
    typealias Select = (Customer?) -> ()
    var didSelect: Select?
    
    var fetchedResultsController = CoreDataManager.instance.fetchedResultsController("Customer", keyForSort: "fullName")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if didSelect != nil {
            addButton.enabled = false
        }
        
        fetchedResultsController.delegate = self
        do {
            try fetchedResultsController.performFetch()
        } catch {
            print(error)
        }
    }
    
    // MARK: - Table View Data Source
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let sections = fetchedResultsController.sections {
            return sections[section].numberOfObjects
        } else {
            return 0
        }
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let customer = fetchedResultsController.objectAtIndexPath(indexPath) as! Customer
        let cell = UITableViewCell()
        cell.textLabel?.text = customer.fullName
        return cell
    }
    @IBAction func AddCustomer(sender: UIBarButtonItem) {
        performSegueWithIdentifier("customersToCustomer", sender: nil)
    }
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let customer = fetchedResultsController.objectAtIndexPath(indexPath) as? Customer
        if let dSelect = self.didSelect {
            dSelect(customer)
            dismissViewControllerAnimated(true, completion: nil)
        } else {
            performSegueWithIdentifier("customersToCustomer", sender: customer)
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "customersToCustomer" {
            let controller = segue.destinationViewController as! CustomerViewController
            controller.entity = sender as? Customer
        }
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            let managedObject = fetchedResultsController.objectAtIndexPath(indexPath) as! NSManagedObject
            CoreDataManager.instance.managedObjectContext.deleteObject(managedObject)
            CoreDataManager.instance.saveContext()
        }
    }
    
    // MARK: - Fetched Results Controller Delegate
    
    func controllerWillChangeContent(controller: NSFetchedResultsController) {
        tableView.beginUpdates()
    }
    
    func controller(controller: NSFetchedResultsController, didChangeObject anObject: AnyObject, atIndexPath indexPath: NSIndexPath?, forChangeType type: NSFetchedResultsChangeType, newIndexPath: NSIndexPath?) {
        switch type {
        case .Insert:
            if let indexPath = newIndexPath {
                tableView.insertRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
            }
        case .Update:
            if let indexPath = indexPath {
                let customer = fetchedResultsController.objectAtIndexPath(indexPath) as! Customer
                let cell = tableView.cellForRowAtIndexPath(indexPath)
                cell!.textLabel?.text = customer.fullName
            }
        case .Move:
            if let indexPath = indexPath {
                tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
            }
            if let newIndexPath = newIndexPath {
                tableView.insertRowsAtIndexPaths([newIndexPath], withRowAnimation: .Automatic)
            }
        case .Delete:
            if let indexPath = indexPath {
                tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
            }
        }
    }
    
    func controllerDidChangeContent(controller: NSFetchedResultsController) {
        tableView.endUpdates()
    }
}
