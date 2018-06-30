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

protocol CategoryCollectionModelDelegate {
    func dataDidLoad()
}

class CategoryCollectionModel: NSObject {
    let db = Firestore.firestore()
    let imagesRef = Storage.storage().reference(withPath: "CategoryImages")
    
    var delegate: CategoryCollectionModelDelegate? = nil
    
    var categories = [[String : Any]]()
    var categoryNames: [String]!
    var categoryImagePaths: [String]!
    var categoryImages = [UIImage]()
  
    func fetchCategories () {
        db.collection("categories").getDocuments(completion: { (querySnapshot, err) in
            if let err = err {
                dLog("error occured: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    self.categories.append(document.data())
                }
            }
            self.categoryNames = self.categories.map {$0["categoryName"] as! String}
            self.categoryImagePaths = self.categories.map {$0["imagePath"] as! String}
            self.fetchCategoryImages()
        })
    }
    
    func fetchCategoryImages () {
        for imagePath in categoryImagePaths {
            imagesRef.child(imagePath + ".jpeg").getData(maxSize: 1 * 1024 * 1024) { (data, error) in
                if let error = error {
                    dLog(error)
                } else {
                    self.categoryImages.append(UIImage(data: data!)!)
                }
            }
        }
        wait({self.categoryImages.count != self.categories.count}) {
            self.didFetchData()
        }
        
    }
    
    func didFetchData () {
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
        cell.backGroundImageView?.image = categoryImages[indexPath.row]
        return cell
    }
}

extension CategoryCollectionModel {
    func wait(_ waitContinuation: @escaping (()->Bool), compleation: @escaping (()->Void)) {
        var wait = waitContinuation()
        // 0.01秒周期で待機条件をクリアするまで待ちます。
        let semaphore = DispatchSemaphore(value: 0)
        DispatchQueue.global().async {
            while wait {
                DispatchQueue.main.async {
                    wait = waitContinuation()
                    semaphore.signal()
                }
                semaphore.wait()
                Thread.sleep(forTimeInterval: 0.01)
            }
            // 待機条件をクリアしたので通過後の処理を行います。
            DispatchQueue.main.async {
                compleation()
            }
        }
    }
}
