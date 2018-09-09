//
//  CouponListCollectionViewCell.swift
//  aboon
//
//  Created by EXIST on 2018/07/29.
//  Copyright © 2018年 aboon. All rights reserved.
//

import UIKit

class CouponListCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var shopNameLabel: UILabel!
    
    func configure(coupon: Coupon, image: UIImage) {
        self.imageView.image = image
        self.nameLabel.text = coupon.name
        self.descriptionLabel.text = coupon.description
        self.shopNameLabel.text = coupon.shopName
        addShadow()
    }
    
    func addShadow() {
        self.layer.masksToBounds = false
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 0.16
        self.layer.shadowOffset = CGSize(width: 0, height: 3)
        self.layer.shadowRadius = 5
    }
}
