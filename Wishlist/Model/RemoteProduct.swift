//
//  RemoteProduct.swift
//  Wishlist
//
//  Created by 김시종 on 4/9/24.
//

import UIKit
import CoreData

struct RemoteProduct: Decodable {
    let id: Int
    let title: String
    let description: String
    let price: Double
    let thumbnail: URL
    
    enum CodingKeys: String, CodingKey {
        case id, title, description, price, thumbnail
    }
}


