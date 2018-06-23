//
//  CategoryCell.swift
//  aboon
//
//  Created by 原口和音 on 2018/06/23.
//  Copyright © 2018 aboon. All rights reserved.
//

import UIKit

class CategoryCell: UICollectionViewCell {
    
    let textLabel: UILabel
    
    required init(model: CategoryModel) {
        
        textLabel = UILabel(frame: CGRect.zero)
        
        super.init(frame: CGRect.zero)
        self.addSubview(textLabel)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        textLabel.frame = self.frame
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
