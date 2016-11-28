//
//  ProductFilter.swift
//  JewelryTrader
//
//  Created by Daniel Slupskiy on 28.11.16.
//  Copyright © 2016 Daniel Slupskiy. All rights reserved.
//

import Foundation
import CoreData

class ProductFilter {
    
    var fetchRequest:NSFetchRequest
    var fetchedResultsController:NSFetchedResultsController {
        let fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: CoreDataManager.instance.managedObjectContext, sectionNameKeyPath: nil, cacheName: nil)
        
        return fetchedResultsController
    }
    
    
    init(withSortKey sortKey: String,
         nameSearchString name: String?,
         minimumPrice minPrice: Float?,
         maximumPrice maxPrice: Float?,
         onlyAvailable available: Bool,
         metalType metal: MetalType?,
         productType type: ProductType?,
         colorType color: Color?) {
        
        fetchRequest = NSFetchRequest(entityName: "Product")
        
        let sortDescriptor = NSSortDescriptor(key: "name", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        if let name = name {
            let predicate = NSPredicate(format: "%K CONTAINS %@", "name", name)
            fetchRequest.predicate = predicate
        }
        
    }
}