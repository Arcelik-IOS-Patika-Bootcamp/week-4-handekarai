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
        setupUI()
    }
    
    func setupUI(){
        var cornerRadius: CGFloat = 5.0

        // Apply rounded corners to contentView
        contentView.layer.cornerRadius = cornerRadius
        contentView.layer.masksToBounds = true
                
        // Set masks to bounds to false to avoid the shadow
        // from being clipped to the corner radius
        layer.cornerRadius = cornerRadius
        layer.masksToBounds = false
                
        // Apply a shadow
        layer.shadowRadius = 8.0
        layer.shadowOpacity = 0.10
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 5)
           
    }
}
