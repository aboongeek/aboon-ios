//
//  CategoryCollectionModel.swift
//  aboon
//
//  Created by 原口和音 on 2018/06/26.
//  Copyright © 2018 aboon. All rights reserved.
//

import UIKit
import Firebase
import RxSwift
import RxCocoa

class CategoryCollectionModel {
    
    static let categoriesRef = Firestore.firestore().collection("categories")
    let imagesRef = Storage.storage().reference(withPath: "CategoryImages")
    
    var numberOfCells: Int = 0
    
    private let categoriesSubject = PublishSubject<[Category]>()
    let categories: Observable<[Category]>
    
    let imagesRelay = BehaviorRelay<[String : UIImage]>(value: [String : UIImage]())
    let images: Observable<[String : UIImage]>

    init(){
        self.categories = categoriesSubject.asObservable()
        self.images = imagesRelay.asObservable()
        
        CategoryCollectionModel.categoriesRef.getDocuments { [weak self] (snapshot, error) in
            guard let snapshot = snapshot, let `self` = self else { return }
            let categories = snapshot.documents.map { document -> Category in
                let data = document.data()
                let path = document.documentID
                let displayName = data["displayName"] as! String
                let imagePath = data["imagePath"] as! String
                
                return Category(path: path, displayName: displayName, imagePath: imagePath)
            }
            self.numberOfCells = categories.count
            self.categoriesSubject.onNext(categories)
            categories.forEach({ [weak self] (category) in
                guard let `self` = self else { return }
                self.fetchImage(category.imagePath)
            })
        }
    }
    
    func fetchImage (_ imagePath: String) {
        self.imagesRef.child(imagePath + ".jpeg").getData(maxSize: 1 * 1024 * 1024) { [weak self] (data, error) in
            guard let data = data, let image = UIImage(data: data), let `self` = self else { return }
            var temp = self.imagesRelay.value
            temp[imagePath] = image
            self.imagesRelay.accept(temp)
        }
    }

}
