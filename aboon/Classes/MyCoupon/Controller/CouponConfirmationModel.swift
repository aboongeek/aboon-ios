//
//  CouponConfirmationModel.swift
//  aboon
//
//  Created by 原口和音 on 2018/08/12.
//  Copyright © 2018年 aboon. All rights reserved.
//

import UIKit
import Firebase

class CouponConfirmationModel {
    
    func useCoupon(roomId: String) {
        Firestore.firestore().collection("rooms").document(roomId).setData(["isUsed" : true])
        
    }
}
