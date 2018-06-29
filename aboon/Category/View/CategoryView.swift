//
//  CategoryView.swift
//  aboon
//
//  Created by 原口 和音 on 2018/06/27.
//  Copyright © 2018年 aboon. All rights reserved.
//

import UIKit

class CategoryView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
    }
    
    public func setFrame (tabBar: UITabBar, navBar: NavigationBar) {
        let frameHeight = UIScreen.main.bounds.size.height - tabBar.frame.size.height - navBar.frame.size.height - UIApplication.shared.statusBarFrame.height
        let frameSize = CGSize(width: UIScreen.main.bounds.size.width, height: frameHeight)
        self.frame = CGRect(origin: frame.origin, size: frameSize)
    }
    
    public func createCollectionView(model: CategoryCollectionModel) -> CategoryCollectionView {
        let customFlowLayout: UICollectionViewFlowLayout = {
            let flowLayout = UICollectionViewFlowLayout()
           
            //constants
            let margin: CGFloat = 20
            let itemRatio: CGFloat = 5/4
            
            //
            let numberOfItems = model.categories.count
            
            //calculated properties
            let itemWidth: CGFloat = (frame.width - 3 * margin) / 2
            let itemSize = CGSize(width: itemWidth , height: itemWidth / itemRatio)
            let numberOfRows = CGFloat(numberOfItems / 2)
            let topInset: CGFloat = (frame.height - (itemSize.height * numberOfRows + margin * (numberOfRows - 1))) / 2
            
            //layout settings
            flowLayout.minimumInteritemSpacing = margin
            flowLayout.minimumLineSpacing = margin
            flowLayout.estimatedItemSize = itemSize
            
            if (topInset <= frame.height) {
                flowLayout.sectionInset = UIEdgeInsetsMake(topInset, margin, margin, margin)
            } else {
                flowLayout.sectionInset = UIEdgeInsetsMake(margin, margin, margin, margin)
            }
            
            return flowLayout
        }()
        let categoryCollectionView = CategoryCollectionView(frame: CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height), collectionViewLayout: customFlowLayout)
        return categoryCollectionView
    }
    
    public func appendCollectionView(collectionView: CategoryCollectionView) {
        self.addSubview(collectionView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
