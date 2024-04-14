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
    var refreshControl: UIRefreshControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupRefreshControl()
    }
    
    func setupTableView() {
        wishListTableView.dataSource = self
        wishListTableView.delegate = self
        wishListTableView.register(UINib(nibName: "WishListTableViewCell", bundle: nil), forCellReuseIdentifier: "WishListCell")
        
        fetchWishListData()
    }
    
    // MARK: - refreshcontrol 구현
    func setupRefreshControl() {
        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshData(_:)), for: .valueChanged)
        wishListTableView.refreshControl = refreshControl
        fetchWishListData()
    }
    
    @objc func refreshData(_ sender: Any) {
        fetchWishListData()
        wishListTableView.refreshControl?.endRefreshing()
    }
    
    // MARK: - 코어데이터 가져와 저장하는 함수
    func fetchWishListData() {
        wishList = CoreDataManager.shared.getWishListFromCoreData()
        wishListTableView.reloadData()
    }
}


    // MARK: - 테이블 뷰 셀 구성
extension WishListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        wishList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "WishListCell", for: indexPath) as! WishListTableViewCell
        let product = wishList[indexPath.row]
        cell.cellPrice.text = "\(product.price)$"
        cell.cellId.text = "\(product.id)"
        cell.cellTitle.text = product.title
        
        cell.selectionStyle = .none
        
        return cell
    }
    
    // MARK: - 셀 삭제 기능
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let productToDelete = wishList[indexPath.row]
            
            CoreDataManager.shared.deleteProduct(productToDelete) {
                self.wishList.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
        }
    }
    
    // MARK: - refreshcontrol 세팅
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        wishListTableView.refreshControl?.beginRefreshing()
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if !decelerate {
            wishListTableView.refreshControl?.endRefreshing()
        }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        wishListTableView.refreshControl?.endRefreshing()
    }
}



