//
//  CategoryCollectionModel.swift
//  aboon
//
//  Created by 原口和音 on 2018/06/26.
//  Copyright © 2018 aboon. All rights reserved.
//

import UIKit
import Firebase

protocol CategoryCollectionModelDelegate {
    func dataDidLoad()
}

class CategoryCollectionModel: NSObject {
    let db = Firestore.firestore()
    
    var delegate: CategoryCollectionModelDelegate? = nil
    
    var categories = [[String : Any]]()
    var categoryNames: [String]!
    var categoryImagePaths: [String]!
    var categoryImages: [UIImage]!
  
    func fetchCategories () {
        dLog("function called")
        db.collection("categories").getDocuments(completion: { (querySnapshot, err) in
            dLog("closure called")
            if let err = err {
                dLog("error occured: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    self.categories.append(document.data())
                    dLog(document.data()["categoryName"])
                }
                self.didFetchData()
            }
        })
    }
    
    func didFetchData () {
        categoryNames = self.categories.map {$0["categoryName"] as! String}
        categoryImagePaths = self.categories.map {$0["imagePath"] as! String}
        delegate?.dataDidLoad()
    }
}

extension CategoryCollectionModel: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoryCell", for: indexPath) as! CategoryCollectionViewCell
        cell.textLabel?.text = categoryNames[indexPath.row]
        return cell
    }
}
