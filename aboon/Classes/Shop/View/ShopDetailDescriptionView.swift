//
//  ShopDetailDescriptionView.swift
//  aboon
//
//  Created by 原口和音 on 2018/08/02.
//  Copyright © 2018年 aboon. All rights reserved.
//

import UIKit

class ShopDetailDescriptionView: UIView {
    
    var nameLabel: UILabel!
    let shopInfoLabel: UILabel!
    var addressLabel: UILabel!
    var businessHoursLabel: UILabel!
    var webURLButton: UIButton!
    var FBURLButton: UIButton!
    var instaURLButton: UIButton!
    var emailLabel: UILabel!
    var phoneLabel: UILabel!
    var descriptionView: UITextView!

    override init(frame: CGRect) {
        
        nameLabel = UILabel(frame: CGRect.zero)
        shopInfoLabel = UILabel(frame: CGRect.zero)
        shopInfoLabel.text = "ショップ情報"
        addressLabel = UILabel(frame: CGRect.zero)
        businessHoursLabel = UILabel(frame: CGRect.zero)
        webURLButton = UIButton(frame: CGRect.zero)
        FBURLButton = UIButton(frame: CGRect.zero)
        instaURLButton = UIButton(frame: CGRect.zero)
        emailLabel = UILabel(frame: CGRect.zero)
        phoneLabel = UILabel(frame: CGRect.zero)
        descriptionView = UITextView(frame: CGRect.zero, textContainer: nil)
        
        super.init(frame: frame)
        
        backgroundColor = .white
        
        addSubview(nameLabel)
        addSubview(shopInfoLabel)
        addSubview(addressLabel)
        addSubview(businessHoursLabel)
        addSubview(webURLButton)
        addSubview(FBURLButton)
        addSubview(instaURLButton)
        addSubview(phoneLabel)
        addSubview(phoneLabel)
        addSubview(descriptionView)
        
        //Viewの下の角を丸める
        if #available(iOS 11.0, *) {
            layer.cornerRadius = frame.width * 0.05
            layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        } else {
            let mask = CAShapeLayer()
            let roundLength = frame.width * 0.05
            let cornerRadii = CGSize(width: roundLength, height: roundLength)
            let path = UIBezierPath(roundedRect: frame, byRoundingCorners: [.bottomLeft, .bottomRight], cornerRadii: cornerRadii)
            mask.path = path.cgPath
            layer.mask = mask
        }
        clipsToBounds = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
