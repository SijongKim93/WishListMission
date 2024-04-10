//
//  WishListTableViewController.swift
//  Wishlist
//
//  Created by 김시종 on 4/9/24.
//

import UIKit

class WishListTableViewController: UITableViewController {
        
    @IBOutlet weak var wishTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.wishTableView.dataSource = self
        
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 0
    }


    
}
