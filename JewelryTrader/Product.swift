//
//  Product.swift
//  JewelryTrader
//
//  Created by Daniel Slupskiy on 28.11.16.
//  Copyright © 2016 Daniel Slupskiy. All rights reserved.
//

import Foundation
import CoreData

@objc(Product)
class Product: NSManagedObject {

    var isSold:Bool {
        return sale != nil
    }
    
    convenience init() {
        self.init(entity: CoreDataManager.instance.entityForName("Product"), insertIntoManagedObjectContext: CoreDataManager.instance.managedObjectContext)
    }
    
    func automaticallyRecountPrice() -> Float {
        var result:Float = 0
        let contentMultiplier = self.metalContent!.content / 100
        let metalPrice = self.metalType!.currentPrice
        var metalWeight = self.weight
        for insertion in self.insertions! {
            if let insertion = insertion as? Insertion {
                let insertionWeight = insertion.weight
                if insertion.isValuable {
                    metalWeight -= insertionWeight
                    result += insertion.price
                }
            }
        }
        result+=metalWeight*(metalPrice*contentMultiplier)
        return result
    }
    
    class func getInsertions(product: Product) -> NSFetchedResultsController {
        
        let fetchRequest = NSFetchRequest(entityName: "Insertion")
        
        let sortDescriptor = NSSortDescriptor(key: "name", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        let predicate = NSPredicate(format: "%K == %@", "product", product)
        fetchRequest.predicate = predicate
        
        let fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: CoreDataManager.instance.managedObjectContext, sectionNameKeyPath: nil, cacheName: nil)
        
        return fetchedResultsController
    }
    class func getAvailableProducts() -> NSFetchedResultsController {
        
        let fetchRequest = NSFetchRequest(entityName: "Product")
        
        let sortDescriptor = NSSortDescriptor(key: "name", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        let predicate = NSPredicate(format: "%K == nil", "sale")
        fetchRequest.predicate = predicate
        
        let fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: CoreDataManager.instance.managedObjectContext, sectionNameKeyPath: nil, cacheName: nil)
        
        return fetchedResultsController
    }
}
