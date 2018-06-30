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
    let categories = ["スポーツ", "カフェ/ダイニング", "ビューティー", "リラクゼーション", "スペシャル", "カップル"]
}

extension CategoryCollectionModel: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoryCell", for: indexPath) as! CategoryCollectionViewCell
        cell.textLabel?.text = categories[indexPath.row]
        return cell
    }
}
