//
//  CategoryView.swift
//  aboon
//
//  Created by 原口和音 on 2018/06/23.
//  Copyright © 2018 aboon. All rights reserved.
//

import UIKit

class CategoryView: UIView {
    
    let categoryCollectionView: UICollectionView
    
    required init(model: CategoryModel) {
       
        categoryCollectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: model.configureLayout())
        categoryCollectionView.register(CategoryCell.self, forCellWithReuseIdentifier: "CategoryCell")
        categoryCollectionView.backgroundColor = .white
        
        super.init(frame: CGRect.zero)
        self.addSubview(categoryCollectionView)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        categoryCollectionView.frame = self.bounds
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
   
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
