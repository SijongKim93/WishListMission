//
//  WishListViewController.swift
//  Wishlist
//
//  Created by 김시종 on 4/12/24.
//

import UIKit
import CoreData

class WishListViewController: UIViewController {

    @IBOutlet weak var wishListTableView: UITableView!
    
    var wishList: [Product] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        wishListTableView.dataSource = self
        wishListTableView.delegate = self
        fetchWishListData()
    }
    
    func fetchWishListData() {
        wishList = CoreDataManager.shared.getWishListFromCoreData()
        wishListTableView.reloadData()
    }
    
}

extension UIViewController: UITableViewDelegate, UITableViewDataSource {
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return wishList.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "WishListCell", for: indexPath) as! WishListTableViewCell
        let product = wishList[indexPath.row]
        cell.cellPrice.text = "\(product.price)$"
        cell.cellId.text = "\(product.id)"
        cell.cellTitle.text = product.title
        
        return cell
        
    }
    
    
}
