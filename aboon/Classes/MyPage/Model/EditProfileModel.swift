//
//  EditProfileModel.swift
//  aboon
//
//  Created by 原口和音 on 2018/08/10.
//  Copyright © 2018年 aboon. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import RxSwift
import RxCocoa

class EditProfileModel {
    
    private let currentUserSubject = PublishSubject<User>()
    let currentUser: Observable<User>
    
    let collectionRef = Firestore.firestore().collection("users")
    
    init() {
        currentUser = currentUserSubject.asObservable()
        fetchUser()
    }
    
    private func fetchUser() {
        guard let FirUser = Auth.auth().currentUser else {
            return
        }
        
        collectionRef.document(FirUser.uid).getDocument { [weak self] (snapshot, error) in
            guard let `self` = self, let snapshot = snapshot, let data = snapshot.data() else { return }
            let userName = data["userName"] as! String
            let email = data["email"] as! String
            let dateOfBirth = data["dateOfBirth"] as! Date
            let gender = data["gender"] as! Gender
            let user = User(userName: userName, email: email, dateOfBirth: dateOfBirth, gender: gender, userId: FirUser.uid)
            self.currentUserSubject.onNext(user)
        }
    }
    
    func updateUser(user: User) {
        collectionRef.document(user.userId).setData([
            "userName"      : user.userName,
            "dateOfBirth"   : user.dateOfBirth,
            "gender"        : user.gender.rawValue,
        ]) { (error) in
            if let error = error {
                dLog("An error has been detected adding a user: \(error)")
            } else {
                dLog("A user has been added successfully.")
            }
        }
    }
    
}
