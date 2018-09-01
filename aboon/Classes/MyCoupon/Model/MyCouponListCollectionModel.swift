//
//  MyCouponListCollectionModel.swift
//  aboon
//
//  Created by EXIST on 2018/07/15.
//  Copyright © 2018年 aboon. All rights reserved.
//

import UIKit
import Firebase
import RxSwift
import RxCocoa

class MyCouponListCollectionModel {
    
    var firUser = Auth.auth().currentUser
    
    var handle: AuthStateDidChangeListenerHandle?
    
    private lazy var collectionRef = Firestore.firestore().collection("users")
    private let storageRef = Storage.storage().reference(withPath: "CouponImages")
    
    private let couponsSubject = PublishSubject<[MyCoupon]>()
    var coupons: Observable<[MyCoupon]> { return couponsSubject.asObservable() }
    
    private let noCouponRelay = BehaviorRelay<Bool>(value: false)
    var noCoupon: Observable<Bool> { return noCouponRelay.asObservable()}
    
    private let imagesRelay = BehaviorRelay<[String : UIImage]>(value: [String : UIImage]())
    var images: Observable<[String : UIImage]> { return imagesRelay.asObservable() }
    
    init() {
        self.handle = Auth.auth().addStateDidChangeListener { [weak self] (auth, user) in
            guard let `self` = self, let user = user else { return }
            self.firUser = user
            self.fetchCoupons(userId: user.uid)
        }
    }
    
    func fetchCoupons(userId: String) {
        collectionRef = collectionRef.document(userId).collection("myCoupons")
        
        collectionRef.order(by: "addedAt").addSnapshotListener { [weak self] (snapshot, error) in
            guard let snapshot = snapshot, let `self` = self else { return }
            let documents = snapshot.documents
            let coupons = documents.map { document -> MyCoupon in
                let data = document.data()
                let imagePath = data["imagePath"] as! String
                let name = data["name"] as! String
                let description = data["description"] as! String
                let minimum = data["minimum"] as! Int
                let shopId = data["shopId"] as! Int
                let isAvailable = data["isAvailable"] as! Bool
                let roomId = document.documentID
                
                return MyCoupon(imagePath: imagePath, name: name, description: description, minimum: minimum, shopId: shopId, isAvailable: isAvailable, roomId: roomId)
                
            }
            if coupons.isEmpty {
                self.noCouponRelay.accept(true)
            } else {
                self.couponsSubject.onNext(coupons)
                coupons.forEach({ [weak self] (coupon) in
                    guard let `self` = self else { return }
                    let imageRef = self.storageRef.child(coupon.shopId.description)
                    self.fetchImage(from: imageRef, withPath: coupon.imagePath)
                })
            }
        }
    }
    
    func fetchImage (from imageRef: StorageReference, withPath imagePath: String) {
        imageRef.child(imagePath).getData(maxSize: 1 * 2048 * 2048) { [weak self] (data, error) in
            guard let data = data, let image = UIImage(data: data), let `self` = self else { return }
            var temp = self.imagesRelay.value
            temp[imagePath] = image
            self.imagesRelay.accept(temp)
        }
    }
    
    func setUserListner() {
        self.handle = Auth.auth().addStateDidChangeListener { (auth, user) in
            self.firUser = user
        }
    }
    
    func removeUserListner() {
        Auth.auth().removeStateDidChangeListener(self.handle!)
    }
}

