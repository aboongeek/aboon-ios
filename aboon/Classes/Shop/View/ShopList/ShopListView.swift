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
    var banner: ShopListCollectionBanner?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor(hex: "F5F5F5")
    }
   
    public func appendViews () {
        shopListCollectionView = ShopListCollectionView(frame: UIScreen.main.bounds, collectionViewLayout: UICollectionViewLayout())
        self.addSubview(shopListCollectionView)
        
        banner = ShopListCollectionBanner(frame: CGRect(origin: CGPoint.zero, size: CGSize(width: frame.width, height: 0)))
        guard let banner = banner else { return }
        addSubview(banner)
        
        banner.translatesAutoresizingMaskIntoConstraints = false
        shopListCollectionView.translatesAutoresizingMaskIntoConstraints = false
        
        if #available(iOS 11.0, *) {
            banner.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor).isActive = true
            banner.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor).isActive = true
            banner.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor).isActive = true
        } else {
            banner.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
            banner.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
            banner.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        }
        banner.bottomAnchor.constraint(equalTo: shopListCollectionView.topAnchor).isActive = true
        
        if #available(iOS 11.0, *) {
            shopListCollectionView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor).isActive = true
            shopListCollectionView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor).isActive = true
            shopListCollectionView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor).isActive = true
        } else {
            shopListCollectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
            shopListCollectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
            shopListCollectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        }

        setNeedsUpdateConstraints()
    }
    
    func bannerShown() {
        guard let banner = banner else { return }
        
        banner.heightAnchor.constraint(equalTo: banner.widthAnchor, multiplier: 0.5).isActive = true
        
        setNeedsUpdateConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
