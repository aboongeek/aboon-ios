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

struct Category {
    let categoryId: Int
    let categoryName: String
    let imagePath: String
}

class CategoryCollectionModel {
    
    let collectionRef = Firestore.firestore().collection("categories")
    let imagesRef = Storage.storage().reference(withPath: "CategoryImages")
    
    var numberOfCells: Int = 0
    
    let categories = BehaviorRelay<[Category]>(value: [Category]())
    let imageRelay = BehaviorRelay<[String : UIImage]>(value: [String : UIImage]())

    init(){
        self.collectionRef.getDocuments { snapshot, error in
            let temp = snapshot?.documents.map { document -> Category in
                let data = document.data()
                let categoryId = data["categoryID"] as! Int
                let categoryName = data["categoryName"] as! String
                let imagePath = data["imagePath"] as! String
                
                return Category(categoryId: categoryId, categoryName: categoryName, imagePath: imagePath)
            }
            self.numberOfCells = (temp?.count)!
            self.categories.accept(temp!)
            self.categories.value.forEach({ (category) in
                self.fetchImage(category.imagePath)
            })
        }
    }
    
    func fetchImage (_ imagePath: String) {
        self.imagesRef.child(imagePath + ".jpeg").getData(maxSize: 1 * 1024 * 1024) { (data, error) in
            let image = UIImage(data: data!)!
            var temp = self.imageRelay.value
            temp[imagePath] = image
            self.imageRelay.accept(temp)
        }
    }

}
