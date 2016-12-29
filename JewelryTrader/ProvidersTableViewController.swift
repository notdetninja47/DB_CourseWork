//
//  ProvidersTableViewController.swift
//  JewelryTrader
//
//  Created by Daniel Slupskiy on 28.11.16.
//  Copyright © 2016 Daniel Slupskiy. All rights reserved.
//

import UIKit
import CoreData

class ProvidersTableViewController: UITableViewController, NSFetchedResultsControllerDelegate {

    typealias Select = (Provider?) -> ()
    var didSelect: Select?
    
    var fetchedResultsController = CoreDataManager.instance.fetchedResultsController("Provider", keyForSort: "name")
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
        let provider = fetchedResultsController.objectAtIndexPath(indexPath) as! Provider
        let cell = UITableViewCell()
        cell.textLabel?.text = provider.name
        return cell
    }
    @IBAction func AddProvider(sender: UIBarButtonItem) {
        performSegueWithIdentifier("providersToProvider", sender: nil)
    }
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let provider = fetchedResultsController.objectAtIndexPath(indexPath) as? Provider
        if let dSelect = self.didSelect {
            dSelect(provider)
            dismissViewControllerAnimated(true, completion: nil)
        } else {
            performSegueWithIdentifier("providersToProvider", sender: provider)
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "providersToProvider" {
            let controller = segue.destinationViewController as! ProviderViewController
            controller.entity = sender as? Provider
        }
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            let entity = fetchedResultsController.objectAtIndexPath(indexPath) as! Provider
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
                let provider = fetchedResultsController.objectAtIndexPath(indexPath) as! Provider
                let cell = tableView.cellForRowAtIndexPath(indexPath)
                cell!.textLabel?.text = provider.name
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
