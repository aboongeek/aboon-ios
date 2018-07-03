//
//  CategoryCollectionModel.swift
//  aboon
//
//  Created by 原口和音 on 2018/06/26.
//  Copyright © 2018 aboon. All rights reserved.
//

import UIKit
import Firebase
import FirebaseStorage
import RxSwift
import RxCocoa

class CategoryCollectionModel: NSObject {
    let db = Firestore.firestore()
    let imagesRef = Storage.storage().reference(withPath: "CategoryImages")
    
    var categories = [[String : Any]]()
    var categoryImages = [String : UIImage]()
    
    var imageCount = BehaviorRelay<Int>(value: 0)
  
    func fetchCategories () -> Observable<[String: Any]> {
        return Observable.create({ (observer) -> Disposable in
            self.db.collection("categories").getDocuments(completion:
                { querySnapshot, error in
                if let error = error {
                    observer.onError(error)
                } else {
                    for document in querySnapshot!.documents {
                        observer.onNext(document.data())
                    }
                    observer.onCompleted()
                }
            })
            return Disposables.create()
        })
        
    }
    
    func fetchCategoryImage (imagePath: String) -> Observable<(UIImage, String)> {
        return Observable.create({ (observer) -> Disposable in
            self.imagesRef.child(imagePath + ".jpeg").getData(maxSize: 1 * 1024 * 1024) { (data, error) in
                if let error = error {
                    observer.onError(error)
                } else {
                    observer.onNext((UIImage(data: data!)!, imagePath))
                }
            }
            return Disposables.create()
        })
    }

}

extension CategoryCollectionModel: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoryCell", for: indexPath) as! CategoryCollectionViewCell
        cell.textLabel?.text = categoryNames[indexPath.row]
        cell.backGroundImageView?.image = categoryImages[categories[indexPath.row]["imagePath"] as! String]
        return cell
    }
}
