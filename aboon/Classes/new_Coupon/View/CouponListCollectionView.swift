//
//  CouponListCollectionView.swift
//  aboon
//
//  Created by EXIST on 2018/07/29.
//  Copyright © 2018年 aboon. All rights reserved.
//

import UIKit

class CouponListCollectionView: UICollectionView {
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        self.collectionViewLayout = generateLayout()
        self.backgroundColor = .clear
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.collectionViewLayout = generateLayout()
    }
    
    func generateLayout() -> UICollectionViewFlowLayout{
        let flowLayout = UICollectionViewFlowLayout()
        let widthMargin = CGFloat(20)
        let heightMargin = CGFloat(16)
        flowLayout.itemSize = CGSize(width: frame.width - 2 * widthMargin, height: 250)
        flowLayout.minimumLineSpacing = heightMargin
        flowLayout.sectionInset = UIEdgeInsets(top: heightMargin, left: widthMargin, bottom: heightMargin, right: widthMargin)
        return flowLayout
    }
    
}
