//
//  TestCoupon.swift
//  aboon
//
//  Created by EXIST on 2018/07/15.
//  Copyright © 2018年 aboon. All rights reserved.
//
import UIKit

class TestCoupon {
    var name: String
    var detail: String
    var image: UIImage? //!!!:DBから取得する場合はは画像のパスになるのでString
    
    var status: Bool?
    
    init(name: String,detail: String, image: UIImage?) {
        self.name = name
        self.detail = detail
        self.image = image
        self.status = false
    }
}
