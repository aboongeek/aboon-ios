//
//  ShopDetailScrollView.swift
//  aboon
//
//  Created by 原口和音 on 2018/08/02.
//  Copyright © 2018年 aboon. All rights reserved.
//

import UIKit

class ShopDetailScrollView: UIScrollView {

    private var _numberOfPages: Int
    var numberOfPages: Int {
        get { return _numberOfPages }
        set(n) { _numberOfPages = n}
    }
    
    init(frame: CGRect, numberOfPages: Int) {
        
        _numberOfPages = numberOfPages

        super.init(frame: frame)

        backgroundColor = .gray
        
        for _ in 0..<numberOfPages {
//            let image = images[i]!
//            let origin = CGPoint(x: frame.width * CGFloat(i), y: frame.origin.y)
//            //imageView.frame.origin = origin
//            var imageRef: CGImage!
//            if image.size.height > image.size.width {
//                imageRef = image.cgImage?.cropping(to: CGRect(origin: origin, size: CGSize(width: image.size.height / image.size.width * frame.width, height: frame.height)))
//            } else {
//                imageRef = image.cgImage?.cropping(to: CGRect(origin: origin, size: CGSize(width: image.size.width / image.size.height * frame.width, height: frame.height)))
//            }
            let imageView = UIImageView()
            
            addSubview(imageView)
        }
        

        self.contentSize = CGSize(width: frame.width * CGFloat(numberOfPages), height: frame.height)
        self.bounces = true
        self.isPagingEnabled = true
        self.showsHorizontalScrollIndicator = false
    }
    
    func addImages(_ images: [UIImage]) {
        subviews.enumerated().forEach { (index, view) in
            (view as! UIImageView).image = images[index]
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
