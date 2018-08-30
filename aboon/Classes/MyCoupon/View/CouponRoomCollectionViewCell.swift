//
//  CouponRoomCollectionViewCell.swift
//  aboon
//
//  Created by 原口和音 on 2018/08/12.
//  Copyright © 2018年 aboon. All rights reserved.
//

import UIKit

class CouponRoomCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var colorView: UIView!
    
    func configure(userName: String) {
        nameLabel.text = userName
        roundEdge()
        addShadow()
    }
    
    func roundEdge() {
        self.layer.cornerRadius = 16
        self.clipsToBounds = true
        
        colorView.layer.cornerRadius = colorView.frame.width / 2
        colorView.clipsToBounds = true
    }
    
    func addShadow() {
        self.layer.masksToBounds = false
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 0.16
        self.layer.shadowOffset = CGSize(width: 0, height: 3)
        self.layer.shadowRadius = 5
    }

}
