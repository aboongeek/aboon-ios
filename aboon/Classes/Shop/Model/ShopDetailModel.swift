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
    
    private let imagesRelay = BehaviorRelay<[String : UIImage]>(value: [String : UIImage]())
    let images: Observable<[String : UIImage]>
    
    init(shopRef: DocumentReference, storageRef: StorageReference) {
        
        documentRef = shopRef
        imagesRef = storageRef
        
        shop = shopSubject.asObservable()
        images = imagesRelay.asObservable()
        
        self.documentRef.getDocument { [weak self] (document, error) in
            guard let document = document, let data = document.data(), let `self` = self else { return }
            
            let imagePaths = data["imagePaths"] as! [String]
            let id = data["id"] as! Int
            let name = data["name"] as! String
            let address = data["address"] as! String
            let businessHours = data["businessHours"] as! String
            let webURL = data["webURL"] as! URL
            let FBURL = data["FBURL"] as! URL
            let instaURL = data["instaURL"] as! URL
            let phone = data["phone"] as! String
            let email = data["email"] as! String
            let description = data["description"] as! String
            
            let shop = Shop(imagePaths: imagePaths, id: id, name: name, address: address, businessHours: businessHours, webURL: webURL, FBURL: FBURL, instaURL: instaURL, phone: phone, email: email, description: description)
           
            self.shopSubject.onNext(shop)
            
            for imagePath in shop.imagePaths {
                self.fetchImage(imagePath)
            }
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
