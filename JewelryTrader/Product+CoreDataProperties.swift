//
//  Product+CoreDataProperties.swift
//  JewelryTrader
//
//  Created by Daniel Slupskiy on 25.12.16.
//  Copyright © 2016 Daniel Slupskiy. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Product {

    @NSManaged var incomePrice: Float
    @NSManaged var isPriceCalculatable: Bool
    @NSManaged var name: String?
    @NSManaged var price: Float
    @NSManaged var size: Float
    @NSManaged var sku: String?
    @NSManaged var supplyDate: NSTimeInterval
    @NSManaged var weight: Float
    @NSManaged var color: Color?
    @NSManaged var insertions: NSSet?
    @NSManaged var metalContent: MetalContent?
    @NSManaged var metalType: MetalType?
    @NSManaged var provider: Provider?
    @NSManaged var sale: Sale?
    @NSManaged var type: ProductType?

}
