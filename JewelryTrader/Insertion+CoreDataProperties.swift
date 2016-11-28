//
//  Insertion+CoreDataProperties.swift
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

extension Insertion {

    @NSManaged var isValuable: Bool
    @NSManaged var name: String?
    @NSManaged var price: Float
    @NSManaged var weight: Float
    @NSManaged var product: Product?
    @NSManaged var type: InsertionType?

}
