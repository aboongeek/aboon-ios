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
import Alamofire
import AlamofireImage

class ShopListCollectionModel {
    
    let firestore = Firestore.firestore()
    let storage = Storage.storage()
    
    lazy var shopCollectionRef = firestore.collection("shops")
    lazy var shopImagesRef = storage.reference(withPath: "ShopImages")
    
    lazy var featuredCollectionRef = firestore.collection("featured")
    lazy var featuredImagesRef = storage.reference(withPath: "FeaturedImages")
    
    private let shopSummariesSubject = PublishSubject<[ShopSummary]>()
    var shopSummaries: Observable<[ShopSummary]> { return shopSummariesSubject.asObservable() }
    
    private let shopImagesRelay = BehaviorRelay<[String : UIImage]>(value: [String : UIImage]())
    var shopImages: Observable<[String : UIImage]> { return shopImagesRelay.asObservable() }
    
    private let featuredsSubject = PublishSubject<[Featured]>()
    var featureds: Observable<[Featured]> { return featuredsSubject.asObservable() }
    
    private let featuredImagesRelay = BehaviorRelay<[String : UIImage]>(value: [String : UIImage]())
    var featuredImages: Observable<[String : UIImage]> { return featuredImagesRelay.asObservable()}

    
    init() {
        fetchShops(of: nil)
        fetchFeatureds()
    }
    
    init(of featuredId: Int) {
        fetchShops(of: featuredId)
    }
    
    private let shopSummary = PublishSubject<ShopSummary>()
    
    private func fetchShops(of featuredId: Int?) {
        
        var query = shopCollectionRef.whereField("isPublic", isEqualTo: true)
        if let featuredId = featuredId {
            query = query.whereField("featuredId", isEqualTo: featuredId)
        }
        
        query.order(by: "id").addSnapshotListener { [weak self] (snapshot, error) in
            guard let snapshot = snapshot, let `self` = self else { return }
            if let error = error {
                dLog(error)
            } else {
                let shopSummaries = snapshot.documents.map { document -> ShopSummary in
                    let data = document.data()
                    let imagePath = (data["imagePaths"] as! [String])[0]
                    let id = data["id"] as! Int
                    let name = data["name"] as! String
                    let categoryName = data["categoryName"] as! String
                    
                    return ShopSummary(imagePath: imagePath, id: id, name: name, categoryName: categoryName, documentRef: document.reference, storageRef: self.shopImagesRef.child(id.description))
                }
                self.shopSummariesSubject.onNext(shopSummaries)
                shopSummaries.forEach({ [weak self] (shopSummary) in
                    guard let `self` = self else { return }
                    self.fetchImage(from: shopSummary.storageRef, withPath: shopSummary.imagePath, imagesRelay: self.shopImagesRelay)
                })
            }
            
        }
    }
    
    private func fetchFeatureds() {
        featuredCollectionRef.whereField("isPublic", isEqualTo: true).getDocuments { [weak self] (snapshot, error) in
            guard let snapshot = snapshot, let `self` = self else { return }
            let featureds = snapshot.documents.map { document -> Featured in
                let data = document.data()
                let name = data["name"] as! String
                let imagePath = data["imagePath"] as! String
                let id = data["id"] as! Int
                
                return Featured(name: name, imagePath: imagePath, id: id)
            }
            self.featuredsSubject.onNext(featureds)
            featureds.forEach({ [weak self] (featured) in
                guard let `self` = self else { return }
                self.fetchImage(from: self.featuredImagesRef.child(featured.id.description), withPath: featured.imagePath, imagesRelay: self.featuredImagesRelay)
            })
        }
    }
    
    private func fetchImage (from ref: StorageReference, withPath imagePath: String, imagesRelay: BehaviorRelay<[String : UIImage]>) {
        ref.child(imagePath).getData(maxSize: 1 * 2048 * 2048) { (data, error) in
            guard let data = data, let image = UIImage(data: data) else {
                return
            }
            var temp = imagesRelay.value
            temp[imagePath] = image
            imagesRelay.accept(temp)
        }
    }
    
    func downloadImages(requests: [URLRequest], imagesRelay: BehaviorRelay<[String : UIImage]>, at imagePath: String) {
        ImageDownloader().download(requests, filter: nil, progress: nil, progressQueue: DispatchQueue.global()) { (response) in
            if let image = response.result.value {
                var temp = imagesRelay.value
                temp[imagePath] = image
                imagesRelay.accept(temp)
            }
        }
    }
    
}
