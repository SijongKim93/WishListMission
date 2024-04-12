//
//  WishListTableViewCell.swift
//  Wishlist
//
//  Created by 김시종 on 4/12/24.
//

import UIKit
import CoreData

class WishListTableViewCell: UITableViewCell {

    
    @IBOutlet weak var cellId: UILabel!
    @IBOutlet weak var cellTitle: UILabel!
    @IBOutlet weak var cellPrice: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
