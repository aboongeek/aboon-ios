//
//  CategoryModel.swift
//  aboon
//
//  Created by 原口和音 on 2018/06/23.
//  Copyright © 2018 aboon. All rights reserved.
//

import UIKit

class CategoryModel: NSObject, UICollectionViewDataSource {
    
    
    func configureLayout () -> UICollectionViewFlowLayout {
        let flowLayout = UICollectionViewFlowLayout()
//        let margin: CGFloat = 3.0
//        flowLayout.itemSize = CGSize(width: 100.0, height: 100.0)
//        flowLayout.minimumInteritemSpacing = margin
//        flowLayout.minimumLineSpacing = margin
//        flowLayout.sectionInset = UIEdgeInsets(top: margin, left: margin, bottom: margin, right: margin)
        return flowLayout
    }

    func allCategories() -> [String] {
        let categories = ["Dining", "Cafe", "Lesson", "Active", "Relax", "Random"]
        return categories
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return allCategories().count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoryCell", for: indexPath) as! CategoryCell
        cell.textLabel.text = allCategories()[indexPath.row]
        cell.backgroundColor = UIColor(red: CGFloat(drand48()),
                                       green: CGFloat(drand48()),
                                       blue: CGFloat(drand48()),
                                       alpha: 1.0)
        return cell
    }

}
