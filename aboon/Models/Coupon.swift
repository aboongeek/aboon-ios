//
//  Coupon.swift
//  aboon
//
//  Created by 原口和音 on 2018/08/12.
//  Copyright © 2018年 aboon. All rights reserved.
//

import Foundation

class Coupon {
    var imagePath: String
    var name: String
    var description: String
    var minimum: Int
    var shopId: Int
    var shopName: String
    
    init(imagePath: String, name: String, description: String, minimum: Int, shopId: Int, shopName: String) {
        self.imagePath = imagePath
        self.name = name
        self.description = description
        self.minimum = minimum
        self.shopId = shopId
        self.shopName = shopName
    }
}

