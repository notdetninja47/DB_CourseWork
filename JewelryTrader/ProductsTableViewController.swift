//
//  ProductsTableViewController.swift
//  JewelryTrader
//
//  Created by Daniel Slupskiy on 28.11.16.
//  Copyright © 2016 Daniel Slupskiy. All rights reserved.
//

import UIKit
import CoreData

class ProductsTableViewController: UITableViewController, NSFetchedResultsControllerDelegate {
    
    typealias Select = (Product?) -> ()
    var didSelect: Select?
    var productFilterState:ProductFilter? {
        didSet{
            fetchedResultsController = productFilterState!.fetchedResultsController
            fetchedResultsController.delegate = self
            do {
                try fetchedResultsController.performFetch()
            } catch {
                print(error)
            }
            tableView.reloadData()
        }
    }
    var fetchedResultsController:NSFetchedResultsController = NSFetchedResultsController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        productFilterState = ProductFilter()
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
        let product = fetchedResultsController.objectAtIndexPath(indexPath) as! Product
        let cell = UITableViewCell()
        cell.textLabel?.text = "\(product.sku ?? "") : \(product.name ?? "")"
        return cell
    }
    @IBAction func AddProduct(sender: UIBarButtonItem) {
        performSegueWithIdentifier("productsToProduct", sender: nil)
    }
    @IBAction func ShowFilter(sender: UIBarButtonItem) {
        performSegueWithIdentifier("showFilter", sender: nil)
    }
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let product = fetchedResultsController.objectAtIndexPath(indexPath) as? Product
        if let dSelect = self.didSelect {
            dSelect(product)
            dismissViewControllerAnimated(true, completion: nil)
        } else {
            performSegueWithIdentifier("productsToProduct", sender: product)
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "productsToProduct" {
            productFilterState = ProductFilter()
            let controller = segue.destinationViewController as! ProductViewController
            controller.entity = sender as? Product
        }
        if segue.identifier == "showFilter" {
            let controller = segue.destinationViewController as! ProductFilterViewController
            controller.productsTable = self
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
                let product = fetchedResultsController.objectAtIndexPath(indexPath) as! Product
                let cell = tableView.cellForRowAtIndexPath(indexPath)
                cell!.textLabel?.text = "\(product.sku ?? "") : \(product.name ?? "")"
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
