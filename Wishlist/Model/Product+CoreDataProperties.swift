//
//  Product+CoreDataProperties.swift
//  Wishlist
//
//  Created by 김시종 on 4/12/24.
//
//

import Foundation
import CoreData


extension Product {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Product> {
        return NSFetchRequest<Product>(entityName: "Product")
    }

    @NSManaged public var id: Int64
    @NSManaged public var price: Double
    @NSManaged public var title: String?

}

extension Product : Identifiable {

}
