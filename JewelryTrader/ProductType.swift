//
//  ProductType.swift
//  JewelryTrader
//
//  Created by Daniel Slupskiy on 28.11.16.
//  Copyright © 2016 Daniel Slupskiy. All rights reserved.
//

import Foundation
import CoreData

@objc(ProductType)
class ProductType: NSManagedObject {
     
    convenience init() {
        self.init(entity: CoreDataManager.instance.entityForName("ProductType"), insertIntoManagedObjectContext: CoreDataManager.instance.managedObjectContext)
    }
    class func getAllProductTypes() -> [ProductType] {
        var results = [ProductType]()
        
        let fetchRequest = NSFetchRequest(entityName: "ProductType")
        do{
            try results = CoreDataManager.instance.managedObjectContext.executeFetchRequest(fetchRequest) as! [ProductType]
        }catch{
            print("FETCH REQUEST ERROR")
        }
        return results
    }
}
