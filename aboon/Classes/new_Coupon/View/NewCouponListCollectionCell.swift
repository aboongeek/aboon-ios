//
//  NewCouponListCollectionViewCell.swift
//  aboon
//
//  Created by EXIST on 2018/07/29.
//  Copyright © 2018年 aboon. All rights reserved.
//

import UIKit
import SnapKit

class NewCouponListCollectionViewCell: UICollectionViewCell {
    
    var couponImageView: UIImageView?
    var couponNameLabel: UILabel?
    var couponDetailLabel: UILabel?
    var couponDiscountLabel: UILabel?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .white
        
        //initialization of imageview
        couponImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: frame.width, height: frame.height/2))
        //using scaleAspectFill considering images that are not cropped
        couponImageView?.contentMode = .scaleAspectFill
        couponImageView?.clipsToBounds = true
        addSubview(couponImageView!)
        //initialization of couponNameLabel
        couponNameLabel = UILabel(frame: CGRect(x: 0, y: 0, width: frame.width*2/3, height: frame.height/2))
        //settings for texts
        couponNameLabel?.font = UIFont(name: "Courier", size: (couponNameLabel?.font.pointSize)!)
        couponNameLabel?.textColor = .black
        //couponNameLabel?.font = UIFont.boldSystemFont(ofSize: (couponNameLabel?.font.pointSize)!)
        couponNameLabel?.text = "nil"
        
        addSubview(couponNameLabel!)
        
        //initialazation of couponDetailLabel
        couponDetailLabel = UILabel(frame: CGRect(x: 0, y: 0, width: frame.width*2/3, height: frame.height/2))
        //setting texts
        couponDetailLabel?.font = UIFont(name:"Calibri", size: (couponNameLabel?.font.pointSize)!/2)
        couponDetailLabel?.textColor = UIColor(hex: "000000", alpha: 0.5)
        couponDetailLabel?.text = "nil"
        
        addSubview(couponDetailLabel!)
        
        //initialazation of couponDiscountLabel
        couponDiscountLabel = UILabel(frame: CGRect(x: 0, y: 0, width: frame.width/3, height: frame.height/2))
        //setting texts
        couponDiscountLabel?.font = UIFont(name:"Calibri", size: (couponDiscountLabel?.font.pointSize)!/2)
        couponDiscountLabel?.textColor = UIColor(hex: "000000", alpha: 0.5)
        couponDiscountLabel?.text = "nil"
        
        addSubview(couponDiscountLabel!)
        
        //set constraints
        updateConstraintsIfNeeded()
    }
    
    
    override func updateConstraints() {
        super.updateConstraints()
        couponImageView?.snp.makeConstraints({ (make) in
            make.width.equalTo(frame.width)
            make.height.equalTo(frame.height/2)
            make.top.left.equalTo(0)
        })
        couponDiscountLabel?.snp.makeConstraints({ (make) in
            make.width.equalTo(frame.width/3)
            make.height.equalTo(frame.height/2)
//            make.top.equalTo(frame.height/2)
            make.top.equalTo((couponImageView?.snp.bottom)!)
            make.left.equalTo(0)
        })
        couponNameLabel?.snp.makeConstraints { (make) in
            make.height.equalTo(frame.height/4)
            make.width.equalTo(frame.width*2/3)
//            make.top.equalTo(frame.height/2)
//            make.left.equalTo(frame.width/3)
            make.top.equalTo((couponImageView?.snp.bottom)!)
            make.left.equalTo((couponDiscountLabel?.snp.right)!)
        }
        couponDetailLabel?.snp.makeConstraints({ (make) in
            make.height.equalTo(frame.height/4)
            make.width.equalTo(frame.width*2/3)
//            make.top.equalTo(frame.height*3/4)
//            make.left.equalTo(frame.width/3)
            make.top.equalTo((couponNameLabel?.snp.bottom)!)
            make.left.equalTo((couponDiscountLabel?.snp.right)!)
        })
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
