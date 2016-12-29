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
    
    var sortKey = "name"
    var nameSearch: String?
    var minPrice: Float?
    var maxPrice: Float?
    var onlyAvailable = true
    var metalType:MetalType?
    var productType:ProductType?
    var color: Color?
    
    var fetchRequest:NSFetchRequest{
        let result = NSFetchRequest(entityName: "Product")
        
        let sortDescriptor = NSSortDescriptor(key: sortKey, ascending: true)
        result.sortDescriptors = [sortDescriptor]
        
        var predicates = [NSPredicate]()
        if let minPrice = minPrice {
            predicates.append(NSPredicate(format: "%K > %@", "price", minPrice))
        }
        if let maxPrice = maxPrice {
            predicates.append(NSPredicate(format: "%K < %@", "price", maxPrice))
        }
        if onlyAvailable {
            predicates.append(NSPredicate(format: "sale = nil"))
        }
        if let metal = metalType {
            predicates.append(NSPredicate(format: "%K == %@", "metalType", metal))
        }
        if let type = productType {
            predicates.append(NSPredicate(format: "%K == %@", "type", type))
        }
        if let color = color {
            predicates.append(NSPredicate(format: "%K <= %@", "color", color))
        }
        
        let compoundPredicate = NSCompoundPredicate(andPredicateWithSubpredicates: predicates)
        result.predicate = compoundPredicate
        
        return result
    }
    var fetchedResultsController:NSFetchedResultsController {
        let fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: CoreDataManager.instance.managedObjectContext, sectionNameKeyPath: nil, cacheName: nil)
        
        return fetchedResultsController
    }
}