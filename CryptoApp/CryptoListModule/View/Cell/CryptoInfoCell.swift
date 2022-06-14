//
//  CryptoInfoCell.swift
//  CryptoApp
//
//  Created by Hande Kara on 6/12/22.
//

import UIKit

class CryptoInfoCell: UICollectionViewCell {

    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var lastUpdatedLabel: UILabel!
    @IBOutlet weak var priceChangePercentage: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
