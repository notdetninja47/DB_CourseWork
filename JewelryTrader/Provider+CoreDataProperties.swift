//
//  Provider+CoreDataProperties.swift
//  JewelryTrader
//
//  Created by Daniel Slupskiy on 28.11.16.
//  Copyright © 2016 Daniel Slupskiy. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Provider {

    @NSManaged var info: String?
    @NSManaged var mail: String?
    @NSManaged var name: String?
    @NSManaged var phone: String?
    @NSManaged var products: NSSet?

}
