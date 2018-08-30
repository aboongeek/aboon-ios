//
//  ShopDetailModel.swift
//  aboon
//
//  Created by 原口和音 on 2018/08/06.
//  Copyright © 2018年 aboon. All rights reserved.
//

import UIKit
import Firebase
import RxSwift
import RxCocoa

class ShopDetailModel {
    
    let documentRef: DocumentReference
    let imagesRef: StorageReference
    
    private let shopSubject = PublishSubject<Shop>()
    let shop: Observable<Shop>
    
    private let imageRelay = BehaviorRelay<(Int, UIImage?)>(value: (0, nil))
    let images: Observable<(Int, UIImage?)>
    
    private var _shop: Shop?
    
    init(shopRef: DocumentReference, storageRef: StorageReference) {
        
        documentRef = shopRef
        imagesRef = storageRef
        
        shop = shopSubject.asObservable()
        images = imageRelay.asObservable()
        
        self.documentRef.getDocument { [weak self] (document, error) in
            guard let document = document, let data = document.data(), let `self` = self else { return }
            
            let imagePaths = data["imagePaths"] as! [String]
            let id = data["id"] as! Int
            let name = data["name"] as! String
            let address = data["address"] as! String
            let businessHours = data["businessHours"] as! String
            let webURL = data["webURL"] as? String
            let fbURL = data["fbURL"] as? String
            let instaURL = data["instaURL"] as? String
            let phone = data["phone"] as? String
            let email = data["email"] as? String
            let description = data["description"] as! String
            
            let shop = Shop(imagePaths: imagePaths, id: id, name: name, address: address, businessHours: businessHours, webURL: webURL, fbURL: fbURL, instaURL: instaURL, phone: phone, email: email, description: description)
           
            self._shop = shop
            self.shopSubject.onNext(shop)
            
            for imagePath in shop.imagePaths {
                self.fetchImage(imagePath)
            }
        }
    }
    
    func fetchImage (_ imagePath: String) {
        self.imagesRef.child(imagePath).getData(maxSize: 1 * 2048 * 2048) { [weak self] (data, error) in
            guard let data = data,
                let image = UIImage(data: data),
                let `self` = self,
                let shop = self._shop,
                let index = shop.imagePaths.index(of: imagePath) else { return }
            
            self.imageRelay.accept((index, image))
        }
    }

}
