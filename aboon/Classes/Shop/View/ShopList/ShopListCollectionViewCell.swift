//
//  ShopListCollectionViewCell.swift
//  aboon
//
//  Created by John Titer on H30/06/30.
//  Copyright © 平成30年 aboon. All rights reserved.
//

import UIKit

class ShopListCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var shopImageView: UIImageView!
    @IBOutlet weak var shopNameLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
   
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    func configure(shopName: String, categoryName: String, image: UIImage) {
        isExclusiveTouch = true
        self.shopImageView.image = image
        self.categoryLabel.text = categoryName
        self.shopNameLabel.text = shopName
        
        roundEdge()
        addShadow()
    }
    
    func roundEdge() {
        let cornerRadius = self.frame.size.width * 0.05
        self.layer.cornerRadius = cornerRadius
        self.shopImageView.layer.cornerRadius = cornerRadius
        if #available(iOS 11.0, *) {
            self.shopImageView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMinXMinYCorner]
        } else {
            let path = UIBezierPath(roundedRect: shopImageView.bounds, byRoundingCorners: [.topLeft, .bottomLeft], cornerRadii: CGSize(width: cornerRadius, height: cornerRadius))
            let mask = CAShapeLayer()
            mask.path = path.cgPath
            self.shopImageView.layer.mask = mask
        }
        self.shopImageView.clipsToBounds = true
    }
    
    func addShadow() {
        self.layer.masksToBounds = false
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 0.16
        self.layer.shadowOffset = CGSize(width: 0, height: 3)
        self.layer.shadowRadius = 5
    }
}
