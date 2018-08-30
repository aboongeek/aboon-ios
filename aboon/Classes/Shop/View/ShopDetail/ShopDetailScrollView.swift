//
//  ShopDetailScrollView.swift
//  aboon
//
//  Created by 原口和音 on 2018/08/02.
//  Copyright © 2018年 aboon. All rights reserved.
//

import UIKit

class ShopDetailScrollView: UIScrollView {

    var numberOfPages = 0
    
    init(frame: CGRect, numberOfPages: Int) {
        super.init(frame: frame)
        backgroundColor = .gray
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        backgroundColor = .gray
    }
    
    var imageViews = [UIImageView]()
    
    func setUpPages(numberOfPages: Int) {
        self.numberOfPages = numberOfPages
        for currentPage in 0..<numberOfPages {
            let position = CGPoint(x: CGFloat(currentPage) * frame.width, y: 0)
            let imageView = UIImageView(frame: CGRect(origin: position, size: frame.size))
            imageViews.append(imageView)
            addSubview(imageView)
        }
        
        self.contentSize = CGSize(width: frame.width * CGFloat(numberOfPages), height: frame.height)
        self.bounces = true
        self.isPagingEnabled = true
        self.showsHorizontalScrollIndicator = false
    }
    
    func addImage(_ imageWithIndex: (Int, UIImage?)) {
        let index = imageWithIndex.0
        if let image = imageWithIndex.1 {
            imageViews[index].image = image
        }
    }

}
