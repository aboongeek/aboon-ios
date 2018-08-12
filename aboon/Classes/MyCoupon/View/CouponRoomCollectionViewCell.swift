//
//  CouponRoomCollectionViewCell.swift
//  aboon
//
//  Created by 原口和音 on 2018/08/12.
//  Copyright © 2018年 aboon. All rights reserved.
//

import UIKit

class CouponRoomCollectionViewCell: UICollectionViewCell {
    
    let nameLabel = UILabel()
    let colorView = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        colorView.backgroundColor = UIColor(hex: "93D3A6")
        
        addSubview(nameLabel)
        addSubview(colorView)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
