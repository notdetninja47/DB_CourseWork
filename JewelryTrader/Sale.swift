//
//  Sale.swift
//  JewelryTrader
//
//  Created by Daniel Slupskiy on 28.11.16.
//  Copyright © 2016 Daniel Slupskiy. All rights reserved.
//

import Foundation
import CoreData

@objc(Sale)
class Sale: NSManagedObject {

    convenience init() {
        self.init(entity: CoreDataManager.instance.entityForName("Sale"), insertIntoManagedObjectContext: CoreDataManager.instance.managedObjectContext)
    }
}
