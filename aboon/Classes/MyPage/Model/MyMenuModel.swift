//
//  MyMenuModel.swift
//  aboon
//
//  Created by EXIST on 2018/07/21.
//  Copyright © 2018年 aboon. All rights reserved.
//

import UIKit
import Firebase
import RxSwift
import RxCocoa

class MyMenuModel {
    
    var user = Auth.auth().currentUser
    let menulist = ["ログイン", "ログアウト", "お問い合わせ"]
    
    private let userNameRelay = BehaviorRelay<String>(value: String())
    var userName: Observable<String> { return userNameRelay.asObservable()}
    
    func refreshUser() {
        self.user = Auth.auth().currentUser
        setUpUserName()
    }
    
    private func setUpUserName() {
        if let user = user {
            Firestore.firestore().collection("users").document("\(user.uid)").getDocument(completion: { [weak self] (snapshot, error) in
                guard let `self` = self, let snapshot = snapshot, let data = snapshot.data() else { return }
                self.userNameRelay.accept(data["userName"] as! String)
            })
        } else {
            userNameRelay.accept("ゲスト")
        }
    }
    
}


