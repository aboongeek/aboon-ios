//
//  MyCoupon.swift
//  aboon
//
//  Created by 原口和音 on 2018/08/12.
//  Copyright © 2018年 aboon. All rights reserved.
//

import Foundation

class MyCoupon: Coupon {
    var isAvailable = false
    var roomId = String()
    
    init(imagePath: String, name: String, description: String, minimum: Int, shopId: Int, isAvailable: Bool, roomId: String) {
        self.isAvailable = isAvailable
        self.roomId = roomId
        super.init(imagePath: imagePath, name: name, description: description, minimum: minimum, shopId: shopId)
    }
}

