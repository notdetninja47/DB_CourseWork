//
//  Customer.swift
//  JewelryTrader
//
//  Created by Daniel Slupskiy on 28.11.16.
//  Copyright © 2016 Daniel Slupskiy. All rights reserved.
//

import Foundation
import CoreData

@objc(Customer)
class Customer: NSManagedObject {

    convenience init() {
        self.init(entity: CoreDataManager.instance.entityForName("Customer"), insertIntoManagedObjectContext: CoreDataManager.instance.managedObjectContext)
    }
}
