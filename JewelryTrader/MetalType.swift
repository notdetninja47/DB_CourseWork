//
//  MetalType.swift
//  JewelryTrader
//
//  Created by Daniel Slupskiy on 28.11.16.
//  Copyright © 2016 Daniel Slupskiy. All rights reserved.
//

import Foundation
import CoreData

@objc(MetalType)
class MetalType: NSManagedObject {

    convenience init() {
        self.init(entity: CoreDataManager.instance.entityForName("MetalType"), insertIntoManagedObjectContext: CoreDataManager.instance.managedObjectContext)
    }
    class func getAllTypes() -> [MetalType] {
        var results = [MetalType]()
        
        let fetchRequest = NSFetchRequest(entityName: "MetalType")
        do{
            try results = CoreDataManager.instance.managedObjectContext.executeFetchRequest(fetchRequest) as! [MetalType]
        }catch{
            print("FETCH REQUEST ERROR")
        }
        return results
    }
}
