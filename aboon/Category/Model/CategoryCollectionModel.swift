//
//  CategoryCollectionModel.swift
//  aboon
//
//  Created by 原口和音 on 2018/06/26.
//  Copyright © 2018 aboon. All rights reserved.
//

import UIKit

class CategoryCollectionModel: NSObject, UICollectionViewDataSource {
    
    let dumImages = [R.image.airplaneSymbol7(), R.image.albumSimple7(), R.image.dotMore7(), R.image.heart7()]
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell = CategoryCollectionViewCell()
        cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoryCollectionViewCell", for: indexPath) as! CategoryCollectionViewCell
        cell.configure(image: dumImages[indexPath.row]!)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }

}
