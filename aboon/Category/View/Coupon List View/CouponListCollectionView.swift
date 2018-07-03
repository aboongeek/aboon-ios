//
//  CouponListCollectionView.swift
//  aboon
//
//  Created by 原口和音 on 2018/06/27.
//  Copyright © 2018 aboon. All rights reserved.
//

import UIKit

class CouponListCollectionView: UICollectionView {
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        //white → 0.96
        self.backgroundColor = UIColor(white: 0.96, alpha: 1)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setLayout(){
        let flowLayout = UICollectionViewFlowLayout()
        let margin = CGFloat(frame.width/4)
        flowLayout.itemSize = CGSize(width: frame.width*7/8, height: frame.height/6.5)
        flowLayout.minimumLineSpacing = margin/8
        flowLayout.sectionInset = UIEdgeInsets(top: margin/8, left: margin, bottom: 0, right: margin)
        self.collectionViewLayout = flowLayout
    }
    
    
}
