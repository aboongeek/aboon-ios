//
//  CategoryCollectionView.swift
//  aboon
//
//  Created by 原口和音 on 2018/06/26.
//  Copyright © 2018 aboon. All rights reserved.
//

import UIKit

class CategoryCollectionView: UICollectionView {
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        
        self.register(CategoryCollectionViewCell.self, forCellWithReuseIdentifier: "CategoryCollectionViewCell")
        
        self.backgroundColor = .white
        
    }
    
    override func layoutSubviews() {
        self.frame = CGRect(x: 0, y: 100, width: bounds.width, height: 400)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
