//
//  SignUpModel.swift
//  aboon
//
//  Created by 原口和音 on 2018/08/08.
//  Copyright © 2018年 aboon. All rights reserved.
//

import Foundation
import Firebase
import FirebaseAuth

class SignUpModel {
    
    let collectionRef = Firestore.firestore().collection("users")
    
    func addUser(user: User) {
        collectionRef.document(user.userId).setData([
            "userId"        : user.userId,
            "userName"      : user.userName,
            "dateOfBirth"   : user.dateOfBirth,
            "gender"        : user.gender.rawValue,
            "addedAt"       : NSDate()
        ]) { (error) in
            if let error = error {
                dLog("An error has been detected adding a user: \(error)")
            } else {
                dLog("A user has been added successfully.")
            }
        }
    }
    
}
