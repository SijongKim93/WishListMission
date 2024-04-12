//
//  CoreDateManager.swift
//  Wishlist
//
//  Created by 김시종 on 4/12/24.
//

import UIKit
import CoreData



class CoreDataManager {
    
    static let shared = CoreDataManager()
    private init() {}
    
    let appDelegate = UIApplication.shared.delegate as? AppDelegate
    lazy var context = appDelegate?.persistentContainer.viewContext
    
    let coreDataName: String = "Product"
    
    
    func getWishListFromCoreData() -> [Product] {
        var wishList: [Product] = []
        
        if let context = context {
            let request = NSFetchRequest<NSManagedObject>(entityName: self.coreDataName)
            let idOrder = NSSortDescriptor(key: "id", ascending: false)
            request.sortDescriptors = [idOrder]
            
            do {
                if let fetchWishList = try context.fetch(request) as? [Product] {
                    wishList = fetchWishList
                }
            } catch {
                print("가져오기 실패")
            }
        }
        
        return wishList
    }
    
    func saveWishListData(_ product: RemoteProduct, completion: @escaping () -> Void) {
        guard let context = context else {
            print("context를 가져올 수 없습니다.")
            return
        }
        
        if let entity = NSEntityDescription.entity(forEntityName: coreDataName, in: context) {
            let newProduct = NSManagedObject(entity: entity, insertInto: context)
            newProduct.setValue(product.id, forKey: "id")
            newProduct.setValue(product.title, forKey: "title")
            newProduct.setValue(product.price, forKey: "price")
            
            do {
                try context.save()
                print("코어데이터에 저장되었습니다.")
                completion()
            } catch {
                print("코어데이터에 저장하는데 실패했습니다.", error)
                completion()
            }
        }
    }
}
