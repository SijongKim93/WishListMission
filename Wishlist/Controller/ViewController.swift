//
//  ViewController.swift
//  Wishlist
//
//  Created by 김시종 on 4/9/24.
//

import UIKit
import CoreData


class ViewController: UIViewController {

    var container: NSPersistentContainer!
    let networkingManager = NetworkingManager()

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
                    self.updateUI(with: product)
                case .failure(let error):
                    print("상품 불러오기가 실패했습니다:", error)
                }
            }
        }
    }
    
    func updateUI(with product: RemoteProduct) {
        imageView.load(url: product.thumbnail)
        titleLabel.text = product.title
        descriptionLabel.text = product.description
        priceLabel.text = "\(product.price)"
    }



    

    
    @IBAction func saveProductButtonTapped(_ sender: UIButton) {
    }
    
    @IBAction func nextProductButtonTapped(_ sender: UIButton) {
    }
    
    @IBAction func lookWishListTapped(_ sender: UIButton) {
        guard let nextVC = self.storyboard?.instantiateViewController(identifier: "WishListTableViewController") as? WishListTableViewController else { return }
        
        self.present(nextVC, animated: true)
    }
    
}


extension UIImageView {
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url),
               let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    self?.image = image
                }
            }
        }
    }
}
