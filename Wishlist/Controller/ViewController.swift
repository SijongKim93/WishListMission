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
    
    // MARK: - 네트워킹된 데이터 가져오기
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
    
    // MARK: - 네트워킹 데이터 컴포넌트와 연결
    func updateUI(with product: RemoteProduct) {
        DispatchQueue.main.async {
            self.imageView.load(url: product.thumbnail)
            self.titleLabel.text = product.title
            self.descriptionLabel.text = product.description
            self.priceLabel.text = "\(product.price)$"
        }
    }
    
    // MARK: - 코어데이터 저장함수 불러와 실행
    @IBAction func saveProductButtonTapped(_ sender: UIButton) {
        guard let product = currentProduct else {
            print("제품 정보가 없습니다.")
            return
        }
        
        wishListManager.saveWishListData(product) {
            print("제품이 저장되었습니다.")
        }
    }
    
    // MARK: - 상품 랜덤 변경
    @IBAction func nextProductButtonTapped(_ sender: UIButton) {
        self.fetchData()
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
