//
//  ProductTypesTableViewController.swift
//  JewelryTrader
//
//  Created by Daniel Slupskiy on 28.11.16.
//  Copyright © 2016 Daniel Slupskiy. All rights reserved.
//

import UIKit
import CoreData

class ProductTypesTableViewController: UITableViewController, NSFetchedResultsControllerDelegate {
    
    @IBOutlet weak var addButton: UIBarButtonItem!
    typealias Select = (ProductType?) -> ()
    var didSelect: Select?

    var fetchedResultsController = CoreDataManager.instance.fetchedResultsController("ProductType", keyForSort: "name")
    
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
        let productType = fetchedResultsController.objectAtIndexPath(indexPath) as! ProductType
        let cell = UITableViewCell()
        cell.textLabel?.text = productType.name
        return cell
    }
    @IBAction func AddProductType(sender: UIBarButtonItem) {
        performSegueWithIdentifier("productTypesToProductType", sender: nil)
    }
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let productType = fetchedResultsController.objectAtIndexPath(indexPath) as? ProductType
        
        if let dSelect = self.didSelect {
            dSelect(productType)
            dismissViewControllerAnimated(true, completion: nil)
        } else {
            performSegueWithIdentifier("productTypesToProductType", sender: productType)
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "productTypesToProductType" {
            let controller = segue.destinationViewController as! ProductTypeViewController
            controller.entity = sender as? ProductType
        }
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            let entity = fetchedResultsController.objectAtIndexPath(indexPath) as! ProductType
            if entity.products!.count == 0 {
                let managedObject = fetchedResultsController.objectAtIndexPath(indexPath) as! NSManagedObject
                CoreDataManager.instance.managedObjectContext.deleteObject(managedObject)
                CoreDataManager.instance.saveContext()
            } else {
                UIAlertView(title: "Некорректное действие", message: "Вы пытаетесь удалить сущность, которая связанна с другими", delegate: nil, cancelButtonTitle: "Отменить").show()
            }
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
                let productType = fetchedResultsController.objectAtIndexPath(indexPath) as! ProductType
                let cell = tableView.cellForRowAtIndexPath(indexPath)
                cell!.textLabel?.text = productType.name
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
