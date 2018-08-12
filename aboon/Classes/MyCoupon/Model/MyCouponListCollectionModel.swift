//
//  MyCouponListCollectionModel.swift
//  aboon
//
//  Created by EXIST on 2018/07/15.
//  Copyright © 2018年 aboon. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import RxSwift
import RxCocoa

class MyCouponListCollectionModel {
    
    let firUser = Auth.auth().currentUser
    
    lazy var collectionRef = Firestore.firestore().collection("users")
    let imagesRef = Storage.storage().reference(withPath: "CouponImage")
    
    private let couponsSubject = PublishSubject<[MyCoupon]>()
    var coupons: Observable<[MyCoupon]> { return couponsSubject.asObservable() }
    
    private let imagesRelay = BehaviorRelay<[String : UIImage]>(value: [String : UIImage]())
    var images: Observable<[String : UIImage]> { return imagesRelay.asObservable() }
    
    private let isUserNotSignedInSubject = PublishSubject<Bool>()
    var isUserNotSignedIn: Observable<Bool> { return isUserNotSignedInSubject.asObservable() }
    
    init() {
        
        guard let firUser = firUser else {
            isUserNotSignedInSubject.onNext(true)
            return
        }
        
        collectionRef = collectionRef.document(firUser.uid).collection("myCoupons")
        
        self.collectionRef.whereField("isPublic", isEqualTo: true).whereField("isUsed", isEqualTo: false).getDocuments { [weak self] (snapshot, error) in
            guard let snapshot = snapshot, let `self` = self else { return }
            let coupons = snapshot.documents.map { document -> MyCoupon in
                let data = document.data()
                let imagePath = data["imagePath"] as! String
                let name = data["name"] as! String
                let description = data["description"] as! String
                let minimum = data["minimum"] as! Int
                let isAvailable = data["isAvailable"] as! Bool
                let roomId = data["roomId"] as! String
                
                return MyCoupon(imagePath: imagePath, name: name, description: description, minimum: minimum, isAvailable: isAvailable, roomId: roomId)
            }
            self.couponsSubject.onNext(coupons)
            coupons.forEach({ [weak self] (coupon) in
                guard let `self` = self else { return }
                self.fetchImage(coupon.imagePath)
            })
        }
    }
    
    func fetchImage (_ imagePath: String) {
        self.imagesRef.child(imagePath).getData(maxSize: 1 * 1024 * 1024) { [weak self] (data, error) in
            guard let data = data, let image = UIImage(data: data), let `self` = self else { return }
            var temp = self.imagesRelay.value
            temp[imagePath] = image
            self.imagesRelay.accept(temp)
        }
    }
}

