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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        wishListTableView.dataSource = self
//        wishListTableView.delegate = self

    }
    
}

//extension UIViewController: UITableViewDelegate, UITableViewDataSource {
//    
//    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        <#code#>
//    }
//    
//    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        <#code#>
//    }
//    
//    
//}
