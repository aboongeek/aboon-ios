//
//  MyCouponListCollectionViewCell.swift
//  aboon
//
//  Created by 原口和音 on 2018/08/12.
//  Copyright © 2018年 aboon. All rights reserved.
//

import UIKit

class MyCouponListCollectionViewCell: UICollectionViewCell {
    
    let couponImageView: UIImageView
    let couponNameLabel: UILabel
    let couponDescriptionLabel: UILabel
    let couponAvailabilityView: UIView
    
    override init(frame: CGRect) {
        
        //initialization of imageview
        couponImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: frame.width, height: frame.height/2))
        //using scaleAspectFill considering images that are not cropped
        couponImageView.contentMode = .scaleAspectFill
        couponImageView.clipsToBounds = true
        
        //initialization of couponNameLabel
        couponNameLabel = UILabel(frame: CGRect(x: 0, y: 0, width: frame.width*2/3, height: frame.height/2))
        //settings for texts
        couponNameLabel.font = UIFont(name: "Roboto", size: 16)
        couponNameLabel.textColor = .black
        //couponNameLabel?.font = UIFont.boldSystemFont(ofSize: (couponNameLabel?.font.pointSize)!)
        couponNameLabel.text = "nil"
        couponNameLabel.adjustsFontSizeToFitWidth = true
        
        //initialazation of couponDescriptionLabel
        couponDescriptionLabel = UILabel(frame: CGRect(x: 0, y: 0, width: frame.width*2/3, height: frame.height/2))
        //setting texts
        couponDescriptionLabel.font = UIFont(name:"Roboto", size: 12)
        couponDescriptionLabel.textColor = UIColor(hex: "000000", alpha: 0.5)
        couponDescriptionLabel.text = "nil"
        couponDescriptionLabel.adjustsFontSizeToFitWidth = true
        
        couponAvailabilityView = UIView(frame: CGRect.zero)
        
        super.init(frame: frame)
        
        self.backgroundColor = .white
        
        addSubview(couponImageView)
        addSubview(couponNameLabel)
        addSubview(couponDescriptionLabel)
        addSubview(couponAvailabilityView)
        
        //set constraints
        updateConstraintsIfNeeded()
    }
    
    override func updateConstraints() {
        super.updateConstraints()
        couponImageView.snp.makeConstraints({ (make) in
            make.width.equalTo(frame.width)
            make.height.equalTo(frame.height/2)
            make.top.left.equalToSuperview()
        })
        couponNameLabel.snp.makeConstraints { (make) in
            make.height.equalTo(frame.height/4)
            make.width.equalTo(frame.width*2/3)
            make.top.equalTo(couponImageView.snp.bottom).offset(10)
            make.right.equalToSuperview().offset(-10)
        }
        couponDescriptionLabel.snp.makeConstraints({ (make) in
            make.height.equalTo(frame.height/4)
            make.width.equalTo(frame.width*2/3)
            make.top.equalTo(couponNameLabel.snp.bottom)
            make.bottom.right.equalToSuperview().offset(-10)
        })
    }
    
    func configure(name: String, description: String, image: UIImage, isAvailable: Bool) {
        self.couponImageView.image = image
        self.couponNameLabel.text = name
        self.couponDescriptionLabel.text = description
        if isAvailable {
            self.couponAvailabilityView.backgroundColor = UIColor(hex: "93D3A6")
        } else {
            self.couponAvailabilityView.backgroundColor = UIColor(hex: "FFC6B7")
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}