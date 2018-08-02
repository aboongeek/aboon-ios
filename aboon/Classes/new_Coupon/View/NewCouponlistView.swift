//
//  NewCouponListView.swift
//  aboon
//
//  Created by EXIST on 2018/07/29.
//  Copyright © 2018年 aboon. All rights reserved.
//

import UIKit


class NewCouponListView: UIView {

    var newCouponListCollectionView: NewCouponListCollectionView!
    
    override init(frame: CGRect) {
        super.init(frame:frame)
        self.frame = UIScreen.main.bounds
    }
    
    public func appendCollectionView (_ collectionView: UICollectionView) {
        self.addSubview(collectionView)
        dLog("NewCouponListCollectionView Appended")
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func createCollectionView () -> NewCouponListCollectionView {
        newCouponListCollectionView = NewCouponListCollectionView(frame: frame, collectionViewLayout: UICollectionViewLayout())
        return newCouponListCollectionView
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        newCouponListCollectionView.setLayout()
    }

    
}
