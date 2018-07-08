//
//  CouponListView.swift
//  aboon
//
//  Created by 原口和音 on 2018/06/27.
//  Copyright © 2018 aboon. All rights reserved.
//

import UIKit

class CouponListView: UIView {
    
    var couponListCollectionView: CouponListCollectionView!
    
    override init(frame: CGRect) {
        super.init(frame:frame)
        self.frame = UIScreen.main.bounds
    }
   
    public func appendCollectionView (_ collectionView: UICollectionView) {
        self.addSubview(collectionView)
        dLog("CouponListCollectionView Appended")
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func createCollectionView () -> CouponListCollectionView {
        couponListCollectionView = CouponListCollectionView(frame: frame, collectionViewLayout: UICollectionViewLayout())
        return couponListCollectionView
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        couponListCollectionView.setLayout()
    }

}
