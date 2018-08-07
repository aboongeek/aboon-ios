//
//  ShopListCollectionModel.swift
//  aboon
//
//  Created by John Titer on H30/06/30.
//  Copyright © 平成30年 aboon. All rights reserved.
//

import UIKit
import Firebase
import RxSwift
import RxCocoa

struct ShopSummary {
    var imagePath: String
    var id: String
    var name: String
    var documentRef: DocumentReference
    var storageRef: StorageReference
}

class ShopListCollectionModel {
    
    let collectionRef: CollectionReference
    let imagesRef: StorageReference
    
    private let shopSummariesSubject = PublishSubject<[ShopSummary]>()
    let shopSummaries: Observable<[ShopSummary]>
    
    let imagesRelay = BehaviorRelay<[String : UIImage]>(value: [String : UIImage]())
    let images: Observable<[String : UIImage]>
    
    init(categoryPath: String) {
        
        collectionRef = CategoryCollectionModel.categoriesRef.document(categoryPath).collection("shops")
        imagesRef = Storage.storage().reference(withPath: "ShopImages").child(categoryPath)
        
        shopSummaries = shopSummariesSubject.asObservable()
        images = imagesRelay.asObservable()
        
        self.collectionRef.getDocuments { [weak self] (snapshot, error) in
            guard let snapshot = snapshot, let `self` = self else { return }
            let shopSummaries = snapshot.documents.map { document -> ShopSummary in
                let data = document.data()
                let imagePath = (data["imagePaths"] as! [String])[0]
                let id = data["id"] as! String
                let name = data["name"] as! String
                
                return ShopSummary(imagePath: imagePath, id: id, name: name, documentRef: document.reference, storageRef: self.imagesRef)
            }
            self.shopSummariesSubject.onNext(shopSummaries)
            shopSummaries.forEach({ [weak self] (shopSummary) in
                guard let `self` = self else { return }
                self.fetchImage(shopSummary.imagePath)
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
    
//
//    let data = document.data()
//    let imagePaths = data["imagePaths"] as! [String]
//    let id = data["id"] as! Int
//    let name = data["name"] as! String
//    let address = data["address"] as! String
//    let webURL = data["webURL"] as! URL
//    let phone = data["phone"] as! String
//    let email = data["email"] as! String
//    let description = data["description"] as! String
//
//    return Shop(imagePaths: imagePaths, id: id, name: name, address: address, webURL: webURL, phone: phone, email: email, description: description)
//
//
//
    
//    //test data
//    var shops = ["shop1", "shop2", "shop3", "shop4", "shop5", "shop6"]
//    var details = ["detailA", "detailB", "detailC", "detailD", "detailE", "detailF"]
//    var shopImages = [R.image.airplaneSymbol7(), R.image.basketball7(), R.image.animalElement7(), R.image.albumSimple7(), R.image.bin7(), R.image.bookCoverTick7()]
   
}
