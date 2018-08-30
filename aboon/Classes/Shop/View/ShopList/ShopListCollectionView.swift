//
//  ShopListCollectionView.swift
//  aboon
//
//  Created by 原口和音 on 2018/06/27.
//  Copyright © 2018 aboon. All rights reserved.
//

import UIKit

class ShopListCollectionView: UICollectionView {
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        setLayout()
        self.backgroundColor = UIColor(hex: "F5F5F5")
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setLayout() {
        let flowLayout = UICollectionViewFlowLayout()
        let widthMargin = CGFloat(20)
        let heightMargin = CGFloat(16)
        let itemSize = CGSize(width: UIScreen.main.bounds.width - (2 * widthMargin), height: 140)
        flowLayout.itemSize = itemSize
        flowLayout.minimumLineSpacing = heightMargin
        flowLayout.sectionInset = UIEdgeInsetsMake (heightMargin, widthMargin, heightMargin, widthMargin)
        self.collectionViewLayout = flowLayout
    }
    
    
}
