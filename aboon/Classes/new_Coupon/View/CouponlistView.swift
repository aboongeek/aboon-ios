//
//  CouponListView.swift
//  aboon
//
//  Created by EXIST on 2018/07/29.
//  Copyright © 2018年 aboon. All rights reserved.
//

import UIKit


class CouponListView: UIView {

    var couponListCollectionView: CouponListCollectionView!
    
    override init(frame: CGRect) {
        super.init(frame:frame)
        self.frame = UIScreen.main.bounds
    }
    
    public func appendCollectionView () {
        self.addSubview(couponListCollectionView)
    }
    
    public func initializeCollectionView () -> CouponListCollectionView {
        couponListCollectionView = CouponListCollectionView(frame: frame, collectionViewLayout: UICollectionViewLayout())
        return couponListCollectionView
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        couponListCollectionView.setLayout()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
