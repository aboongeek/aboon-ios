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
    
    func configure(name: String, description: String, image: UIImage, isAvailable: Bool) {
        self.imageView.image = image
        self.nameLabel.text = name
        self.descriptionLabel.text = description
        
        availabilityView.layer.cornerRadius = availabilityView.frame.width / 2
        availabilityView.clipsToBounds = true
        if isAvailable {
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
