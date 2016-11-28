//
//  Color.swift
//  JewelryTrader
//
//  Created by Daniel Slupskiy on 28.11.16.
//  Copyright © 2016 Daniel Slupskiy. All rights reserved.
//

import Foundation
import CoreData

@objc(Color)
class Color: NSManagedObject {

    convenience init() {
        self.init(entity: CoreDataManager.instance.entityForName("Color"), insertIntoManagedObjectContext: CoreDataManager.instance.managedObjectContext)
    }
}
