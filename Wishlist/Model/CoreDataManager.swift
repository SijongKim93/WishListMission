//
//  CoreDateManager.swift
//  Wishlist
//
//  Created by 김시종 on 4/12/24.
//

import UIKit
import CoreData



class CoreDataManager {
    
    // MARK: - 코어데이터 매니저 싱글톤 만들기
    static let shared = CoreDataManager()
    private init() {}
    
    let appDelegate = UIApplication.shared.delegate as? AppDelegate
    lazy var context = appDelegate?.persistentContainer.viewContext
    
    let coreDataName: String = "Product"
    
    // MARK: - 코어데이터 가져오기
    
    func getWishListFromCoreData() -> [Product] {
        var wishList: [Product] = []
        
        if let context = context {
            let request = NSFetchRequest<NSManagedObject>(entityName: self.coreDataName)
            let idOrder = NSSortDescriptor(key: "id", ascending: true)
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
    
    // MARK: - 코어데이터 저장하기
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
    
    // MARK: - 코어데이터 삭제하기
    func deleteProduct(_ product: Product, completion: @escaping () -> Void) {
        guard let context = context else {
            print("content를 가져올 수 없습니다.")
            return
        }
        
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: coreDataName)
        if let title = product.title {
            fetchRequest.predicate = NSPredicate(format: "title == %@", title)
        }
        
        do {
            if let result = try context.fetch(fetchRequest) as? [NSManagedObject] {
                for object in result {
                    context.delete(object)
                }
                
                try context.save()
                print("삭제가 완료되었습니다.")
                completion()
            }
        } catch {
            print("삭제가 실패했습니다.", error)
            completion()
        }
    }
}
