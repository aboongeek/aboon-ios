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
        self.backgroundColor = UIColor(red: 245, green: 245, blue: 245, alpha: 255)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
