//
//  CategoryCollectionViewCell.swift
//  aboon
//
//  Created by 原口和音 on 2018/06/26.
//  Copyright © 2018 aboon. All rights reserved.
//

import UIKit

class CategoryCollectionViewCell: UICollectionViewCell {
    var image :UIImage?
    
    func configure(image: UIImage) {
        let imageView = UIImageView(image: image)
        imageView.frame = self.frame
        addSubview(imageView)
    }
    
}
