//
//  CouponListView.swift
//  aboon
//
//  Created by 原口和音 on 2018/06/27.
//  Copyright © 2018 aboon. All rights reserved.
//

import UIKit

class CouponListView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.frame = UIScreen.main.bounds
    }
    
    public func createCollectionView () -> CouponListCollectionView {
        let customFlowLayout: UICollectionViewFlowLayout = {
            let layout = UICollectionViewFlowLayout()
            
            //layout property settings to be added
            return layout
        }()
        let collectionView = CouponListCollectionView(frame: self.frame, collectionViewLayout: customFlowLayout)
        return collectionView
    }
    
    public func appendCollectionView (_ collectionView: UICollectionView) {
        self.addSubview(collectionView)
        dLog("CouponListCollectionView Appended")
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
