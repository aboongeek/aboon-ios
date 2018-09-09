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
    
    func useCoupon(roomId: String, members: [Member]) {
        let db = Firestore.firestore()
        db.collection("rooms").document(roomId).setData(["isUsed" : true], merge: true) { error in
            if let error = error {
                dLog(error as NSError)
            }
        }
        
        let batch = db.batch()
        for member in members {
            let document = db.collection("users").document(member.userId).collection("myCoupons").document(roomId)
            batch.setData(["isUsed" : true], forDocument: document, merge: true)
        }
    
        batch.commit() { error in
            if let error = error {
                dLog(error as NSError)
            }
        }
    }
}
