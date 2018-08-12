//
//  CouponRoomCollectionView.swift
//  aboon
//
//  Created by 原口和音 on 2018/08/12.
//  Copyright © 2018年 aboon. All rights reserved.
//

import UIKit

class CouponRoomCollectionView: UICollectionView {

    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        self.collectionViewLayout = makeLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func makeLayout() -> UICollectionViewFlowLayout {
        let flowLayout = UICollectionViewFlowLayout()
        let margin = CGFloat(frame.width/4)
        flowLayout.itemSize = CGSize(width: frame.width*7/8, height: frame.height/3)
        flowLayout.minimumLineSpacing = margin/8
        flowLayout.sectionInset = UIEdgeInsets(top: margin/8, left: margin, bottom: 0, right: margin)
        return flowLayout
    }

}
