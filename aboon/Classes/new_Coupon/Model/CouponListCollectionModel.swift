//
//  CouponListCollectionModel.swift
//  aboon
//
//  Created by EXIST on 2018/07/29.
//  Copyright © 2018年 aboon. All rights reserved.
//

import UIKit
import Firebase
import RxSwift
import RxCocoa

class CouponListCollectionModel {
    
    let collectionRef: CollectionReference
    let imagesRef: StorageReference
    
    private let couponsSubject = PublishSubject<[Coupon]>()
    let coupons: Observable<[Coupon]>
    
    private let imagesRelay = BehaviorRelay<[String : UIImage]>(value: [String : UIImage]())
    let images: Observable<[String : UIImage]>
    
    init(shopId: Int) {
        
        collectionRef = Firestore.firestore().collection("coupons")
        imagesRef = Storage.storage().reference(withPath: "CouponImages").child(shopId.description)
        
        coupons = couponsSubject.asObservable()
        images = imagesRelay.asObservable()
        
        self.collectionRef.whereField("shopId", isEqualTo: shopId).whereField("isPublic", isEqualTo: true).getDocuments { [weak self] (snapshot, error) in
            guard let snapshot = snapshot, let `self` = self else { return }
            let coupons = snapshot.documents.map { document -> Coupon in
                let data = document.data()
                let imagePath = data["imagePath"] as! String
                let name = data["name"] as! String
                let description = data["description"] as! String
                let minimum = data["minimum"] as! Int
                let shopId = data["shopId"] as! Int
                let shopName = data["shopName"] as! String
                
                return Coupon(imagePath: imagePath, name: name, description: description, minimum: minimum, shopId: shopId, shopName: shopName)
            }
            self.couponsSubject.onNext(coupons)
            coupons.forEach({ [weak self] (coupon) in
                guard let `self` = self else { return }
                self.fetchImage(coupon.imagePath)
            })
        }
    }
    
    func fetchImage (_ imagePath: String) {
        self.imagesRef.child(imagePath).getData(maxSize: 1 * 2048 * 2048) { [weak self] (data, error) in
            guard let data = data, let image = UIImage(data: data), let `self` = self else { return }
            var temp = self.imagesRelay.value
            temp[imagePath] = image
            self.imagesRelay.accept(temp)
        }
    }
}
