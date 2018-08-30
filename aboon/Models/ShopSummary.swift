//
//  ShopSummary.swift
//  aboon
//
//  Created by 原口和音 on 2018/08/12.
//  Copyright © 2018年 aboon. All rights reserved.
//

import Foundation
import Firebase

struct ShopSummary {
    var imagePath: String
    var id: Int
    var name: String
    var categoryName: String
    var documentRef: DocumentReference
    var storageRef: StorageReference
}

