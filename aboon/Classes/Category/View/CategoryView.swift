//
//  CategoryView.swift
//  aboon
//
//  Created by 原口 和音 on 2018/06/27.
//  Copyright © 2018年 aboon. All rights reserved.
//

import UIKit

class CategoryView: UIView {
    
    var categoryCollectionView: CategoryCollectionView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
    }

    public func initializeCollectionView() -> CategoryCollectionView {
        categoryCollectionView = CategoryCollectionView(frame: CGRect(x: 0, y: 0, width: frame.width, height: frame.height), collectionViewLayout: UICollectionViewFlowLayout())
        return categoryCollectionView
    }
    
    public func appendCollectionView() {
        self.addSubview(categoryCollectionView)
        
        categoryCollectionView.translatesAutoresizingMaskIntoConstraints = false
        if #available(iOS 11.0, *) {
            categoryCollectionView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor).isActive = true
            categoryCollectionView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor).isActive = true
            categoryCollectionView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor).isActive = true
            categoryCollectionView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor).isActive = true
        } else {
            categoryCollectionView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
            categoryCollectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
            categoryCollectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
            categoryCollectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
