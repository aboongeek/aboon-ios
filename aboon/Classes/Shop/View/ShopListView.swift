//
//  ShopListView.swift
//  aboon
//
//  Created by 原口和音 on 2018/06/27.
//  Copyright © 2018 aboon. All rights reserved.
//

import UIKit

class ShopListView: UIView {
    
    var shopListCollectionView: ShopListCollectionView!
    
    override init(frame: CGRect) {
        super.init(frame:frame)
        self.frame = UIScreen.main.bounds
    }
   
    public func appendCollectionView () {
        self.addSubview(shopListCollectionView)
        dLog("ShopListCollectionView Appended")
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func initializeShopListView () -> ShopListCollectionView {
        shopListCollectionView = ShopListCollectionView(frame: frame, collectionViewLayout: UICollectionViewLayout())
        return shopListCollectionView
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        shopListCollectionView.setLayout()
    }

}
