//
//  CouponListCollectionViewCell.swift
//  aboon
//
//  Created by John Titer on H30/06/30.
//  Copyright © 平成30年 aboon. All rights reserved.
//

import UIKit
import SnapKit
class CouponListCollectionViewCell: UICollectionViewCell {
    
    var couponImageView: UIImageView?
    var couponNameLabel: UILabel?
    var couponDetailLabel: UILabel?
    
    override init(frame: CGRect){
        super.init(frame: frame)
        
        self.backgroundColor = .white
        //initialization of imageview
        couponImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: frame.width/2, height: frame.height))
        couponImageView?.contentMode = .scaleAspectFill
        
        addSubview(couponImageView!)
        //initialization of couponNameLabel
        couponNameLabel = UILabel(frame: CGRect(x: 0, y: 0, width: frame.width, height: frame.height))
        //settings for texts
        couponNameLabel?.textColor = .black
        couponNameLabel?.font = UIFont.boldSystemFont(ofSize: (couponNameLabel?.font.pointSize)!)
        couponNameLabel?.text = "nil"
        //constraint settings
        
        addSubview(couponNameLabel!)
        //initialazation of couponDetailLabel
        couponDetailLabel = UILabel(frame: CGRect(x: 0, y: 0, width: frame.width, height: frame.height))
        //setting texts
        couponDetailLabel?.textColor = .black
        couponDetailLabel?.text = "nil"
        //constraint settings
        
        
        addSubview(couponDetailLabel!)
        
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
