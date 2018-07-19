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

class CategoryCollectionCellModel {
    
    let collectionRef = Firestore.firestore().collection("categories")
    let imagesRef = Storage.storage().reference(withPath: "CategoryImages")
    
    var numberOfCells: Int = 0
    
    let categories = BehaviorRelay<[Category]>(value: [Category]())
    let imageRelay = BehaviorRelay<[String : UIImage]>(value: [String : UIImage]())

    init(){
        self.collectionRef.getDocuments { snapshot, error in
            let categories = snapshot?.documents.map { document -> Category in
                let data = document.data()
                let categoryId = data["categoryID"] as! Int
                let categoryName = data["categoryName"] as! String
                let imagePath = data["imagePath"] as! String
                
                return Category(categoryId: categoryId, categoryName: categoryName, imagePath: imagePath)
            }
            self.numberOfCells = (categories?.count)!
            self.categories.accept(categories!)
            self.categories.value.forEach({ (category) in
                self.fetchImage(category.imagePath)
            })
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoryCell", for: indexPath) as! CategoryCollectionViewCell
        cell.textLabel?.text = categories[indexPath.row]["categoryName"] as? String
        cell.backGroundImageView?.image = categoryImages[categories[indexPath.row]["imagePath"] as! String]
        return cell
    }
}
