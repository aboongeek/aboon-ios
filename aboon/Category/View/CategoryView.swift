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
        self.frame = UIScreen.main.bounds
    }
    
    public func createCollectionView() -> CategoryCollectionView{
        let customFlowLayout: UICollectionViewFlowLayout = {
            let flowLayout = UICollectionViewFlowLayout()
            let margin: CGFloat = 16.0
            flowLayout.minimumInteritemSpacing = margin
            flowLayout.minimumLineSpacing = margin
            flowLayout.estimatedItemSize = CGSize(width: 160, height: 128)
            flowLayout.sectionInset = UIEdgeInsetsMake(margin, margin, 0, margin)
            return flowLayout
        }()
        let categoryCollectionView = CategoryCollectionView(frame: CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height), collectionViewLayout: customFlowLayout)
        return categoryCollectionView
    }
    
    public func appendCollectionView(collectionView: CategoryCollectionView) {
        self.addSubview(collectionView)
        dLog("COLLECTIONVIEW APPENDED")
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

class CategoryCollectionView: UICollectionView {
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        self.backgroundColor = .white
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}

