//
//  CouponRoomInviteViewCell.swift
//  aboon
//
//  Created by 原口和音 on 2018/08/12.
//  Copyright © 2018年 aboon. All rights reserved.
//

import UIKit

class CouponRoomInviteViewCell: UICollectionViewCell {
    
    let inviteButton = UIButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        inviteButton.setTitle("友達を誘う", for: .normal)
        
        addSubview(inviteButton)
        inviteButton.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        inviteButton.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
