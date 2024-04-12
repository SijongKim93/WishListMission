//
//  ViewController.swift
//  Wishlist
//
//  Created by 김시종 on 4/9/24.
//

import UIKit
import CoreData


class ViewController: UIViewController {

    var currentProduct: RemoteProduct?
    let networkingManager = NetworkingManager()
    let wishListManager = CoreDataManager.shared

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchData()
    }
    
    func fetchData() {
        networkingManager.getMethod { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let product):
                    self.currentProduct = product
                    self.updateUI(with: product)
                case .failure(let error):
                    print("상품 불러오기가 실패했습니다:", error)
                }
            }
        }
    }
    
    func updateUI(with product: RemoteProduct) {
        DispatchQueue.main.async {
            self.imageView.load(url: product.thumbnail)
            self.titleLabel.text = product.title
            self.descriptionLabel.text = product.description
            self.priceLabel.text = "\(product.price)$"
        }
    }
    
    
    @IBAction func saveProductButtonTapped(_ sender: UIButton) {
        guard let product = currentProduct else {
            print("제품 정보가 없습니다.")
            return
        }
        
        wishListManager.saveWishListData(product) {
            print("제품이 저장되었습니다.")
        }
    }
    
    
    @IBAction func nextProductButtonTapped(_ sender: UIButton) {
        self.fetchData()
    }
    
    @IBAction func lookWishListTapped(_ sender: UIButton) {
        guard let secondVC = storyboard?.instantiateViewController(withIdentifier: "secondVC") as? WishListViewController else { return }
        
        present(secondVC, animated: true)
    }
}


extension UIImageView {
    func load(url: URL) {
        DispatchQueue.global(qos: .background).async { [weak self] in
            if let data = try? Data(contentsOf: url),
               let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    self?.image = image
                }
            }
        }
    }
}
