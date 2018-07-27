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
    
    let couponImageView: UIImageView
    let couponNameLabel: UILabel
//    let couponDetailLabel: UILabel
    
    override init(frame: CGRect){
        
        //initialization of imageview
        couponImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: frame.width/2, height: frame.height))
        //using scaleAspectFill considering images that are not cropped
        couponImageView.contentMode = .scaleAspectFill

        //initialization of couponNameLabel
        couponNameLabel = UILabel(frame: CGRect(x: 0, y: 0, width: frame.width, height: frame.height))
        //settings for texts
        couponNameLabel.font = UIFont(name: "Courier", size: couponNameLabel.font.pointSize)
        couponNameLabel.textColor = .black
        //couponNameLabel?.font = UIFont.boldSystemFont(ofSize: (couponNameLabel?.font.pointSize)!)
        couponNameLabel.text = ""
        
//        //initialazation of couponDetailLabel
//        couponDetailLabel = UILabel(frame: CGRect(x: 0, y: 0, width: frame.width, height: frame.height))
//        //setting texts
//        couponDetailLabel.font = UIFont(name:"Calibri", size: couponNameLabel.font.pointSize/2)
//        couponDetailLabel.textColor = UIColor(hex: "000000", alpha: 0.5)
//        couponDetailLabel.text = "nil"
        
        super.init(frame: frame)
        
        addSubview(couponImageView)
        addSubview(couponNameLabel)
//        addSubview(couponDetailLabel)
        
        self.backgroundColor = .white

        roundEdge()
        //set constraints
        updateConstraintsIfNeeded()
    }
    
    override func updateConstraints() {
        super.updateConstraints()
        
        couponImageView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        couponImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        couponImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        
        couponNameLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        couponNameLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        
//        couponNameLabel.snp.makeConstraints { (make) in
//            make.height.equalTo(frame.height/4)
//            make.left.equalTo(frame.width/2)
//        }
//        couponDetailLabel.snp.makeConstraints({ (make) in
//            make.height.equalTo(frame.height)
//            make.left.equalTo(frame.width/2)
//        })
    }
    
    func configure(text: String, image: UIImage) {
        self.couponImageView.image = image
        self.couponNameLabel.text = text
    }
    
    func roundEdge() {
        self.layer.cornerRadius = self.frame.size.width * 0.05
        self.clipsToBounds = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
