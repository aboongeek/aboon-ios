//
//  CategoryCollectionView.swift
//  aboon
//
//  Created by 原口和音 on 2018/06/27.
//  Copyright © 2018 aboon. All rights reserved.
//

import UIKit

class CategoryCollectionView: UICollectionView {
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        self.backgroundColor = .clear
    }
    
    public func setCollectionViewLayout (numberOfCells: Int) {
        let flowLayout = UICollectionViewFlowLayout()
        
        //constants
        let margin: CGFloat = 20
        let itemRatio: CGFloat = 5/4
        
        //calculated properties
        let itemWidth: CGFloat = (frame.width - 3 * margin) / 2
        let itemSize = CGSize(width: itemWidth , height: itemWidth / itemRatio)
        let numberOfRows = CGFloat(numberOfCells / 2)
        let topInset: CGFloat = (frame.height - (itemSize.height * numberOfRows + margin * (numberOfRows - 1))) / 2
        
        //layout settings
        flowLayout.minimumInteritemSpacing = margin
        flowLayout.minimumLineSpacing = margin
        flowLayout.estimatedItemSize = itemSize
        
        if (topInset > margin) {
            flowLayout.sectionInset = UIEdgeInsetsMake(topInset, margin, margin, margin)
        } else {
            flowLayout.sectionInset = UIEdgeInsetsMake(margin, margin, margin, margin)
        }
        
        self.collectionViewLayout = flowLayout
        self.backgroundColor = UIColor(red: 245, green: 245, blue: 245, alpha: 255)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
