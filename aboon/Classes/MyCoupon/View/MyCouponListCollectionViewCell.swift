//
//  MyCouponListCollectionViewCell.swift
//  aboon
//
//  Created by 原口和音 on 2018/08/12.
//  Copyright © 2018年 aboon. All rights reserved.
//

import UIKit

class MyCouponListCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var availabilityView: UIView!
    @IBOutlet weak var shopNameLabel: UILabel!
    
    func configure(coupon: MyCoupon, image: UIImage) {
        self.imageView.image = image
        self.nameLabel.text = coupon.name
        self.descriptionLabel.text = coupon.description
        self.shopNameLabel.text = coupon.shopName
        
        availabilityView.layer.cornerRadius = availabilityView.frame.width / 2
        availabilityView.clipsToBounds = true
        if coupon.isAvailable {
            self.availabilityView.backgroundColor = UIColor(hex: "93D3A6")
        } else {
            self.availabilityView.backgroundColor = UIColor(hex: "FFC6B7")
        }
        
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
