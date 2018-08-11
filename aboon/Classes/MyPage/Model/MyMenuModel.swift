//
//  MyMenuModel.swift
//  aboon
//
//  Created by EXIST on 2018/07/21.
//  Copyright © 2018年 aboon. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class MyMenuModel {
    
    let user = Auth.auth().currentUser
    var userName = String()
    let menulist = ["アカウント編集", "カスタマーサービス"]
    
    init() {
        if let user = user {
            Firestore.firestore().collection("user").document("\(user.uid)").getDocument(completion: { [weak self] (snapshot, error) in
                guard let `self` = self, let snapshot = snapshot, let data = snapshot.data() else { return }
                self.userName = data["userName"] as! String
            })
        } else {
            userName = "ゲスト"
        }

//        Firestore.firestore().collection("user").whereField("userId", isEqualTo: user.uid).getDocuments { [weak self] (snapshot, error) in
//            guard let `self` = self, let snapshot = snapshot else { return }
//            self.userName = snapshot.documents[0].data()["userName"] as! String
//        }
    }
    
}


