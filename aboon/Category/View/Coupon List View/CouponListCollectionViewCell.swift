//
//  CouponListCollectionViewCell.swift
//  aboon
//
//  Created by John Titer on H30/06/30.
//  Copyright © 平成30年 aboon. All rights reserved.
//

import UIKit

class CouponListCollectionViewCell: UICollectionViewCell {
    
    var couponImageView: UIImageView?
    var couponNameLabel: UILabel?
    var couponDetailLabel: UILabel?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .gray
        //initialization of imageview
        couponImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: frame.width, height: frame.height))
        addSubview(couponImageView!)
        //initialization of couponNameLabel
        couponNameLabel = UILabel(frame: CGRect(x: 0, y: 0, width: frame.width, height: frame.height))
        //settings for texts
        couponNameLabel?.textAlignment = .left
        couponNameLabel?.textColor = .black
        couponNameLabel?.font = UIFont.boldSystemFont(ofSize: (couponNameLabel?.font.pointSize)!)
        couponNameLabel?.text = "nil"
        //constraints for the label
        
        
        addSubview(couponNameLabel!)
        //initialazation of couponDetailLabel
        couponDetailLabel = UILabel(frame: CGRect(x: 0, y: 0, width: frame.width, height: frame.height))
        //setting texts
        couponDetailLabel?.textAlignment = .left
        couponDetailLabel?.textColor = .black
        couponDetailLabel?.text = "nil"
        
        addSubview((couponDetailLabel!))
        
        //この後影をつける
        
        roundEdge()
    }
    
    func roundEdge() {
        self.layer.cornerRadius = self.frame.size.width * 0.05
        self.clipsToBounds = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
