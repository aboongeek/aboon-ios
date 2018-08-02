//
//  ShopListCollectionViewCell.swift
//  aboon
//
//  Created by John Titer on H30/06/30.
//  Copyright © 平成30年 aboon. All rights reserved.
//

import UIKit
import SnapKit

class ShopListCollectionViewCell: UICollectionViewCell {
    
    let shopImageView: UIImageView
    let shopNameLabel: UILabel
//    let shopDetailLabel: UILabel
    
    override init(frame: CGRect){
        
        //initialization of imageview
        shopImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: frame.width/2, height: frame.height))
        //using scaleAspectFill considering images that are not cropped
        shopImageView.contentMode = .scaleAspectFill

        //initialization of shopNameLabel
        shopNameLabel = UILabel(frame: CGRect(x: 0, y: 0, width: frame.width, height: frame.height))
        //settings for texts
        shopNameLabel.font = UIFont(name: "Courier", size: shopNameLabel.font.pointSize)
        shopNameLabel.textColor = .black
        //shopNameLabel?.font = UIFont.boldSystemFont(ofSize: (shopNameLabel?.font.pointSize)!)
        shopNameLabel.text = ""
        
//        //initialazation of shopDetailLabel
//        shopDetailLabel = UILabel(frame: CGRect(x: 0, y: 0, width: frame.width, height: frame.height))
//        //setting texts
//        shopDetailLabel.font = UIFont(name:"Calibri", size: shopNameLabel.font.pointSize/2)
//        shopDetailLabel.textColor = UIColor(hex: "000000", alpha: 0.5)
//        shopDetailLabel.text = "nil"
        
        super.init(frame: frame)
        
        addSubview(shopImageView)
        addSubview(shopNameLabel)
//        addSubview(shopDetailLabel)
        
        self.backgroundColor = .white

        roundEdge()
        //set constraints
        updateConstraintsIfNeeded()
    }
    
    override func updateConstraints() {
        super.updateConstraints()
        
        shopImageView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        shopImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        shopImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        
        shopNameLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        shopNameLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        
//        shopNameLabel.snp.makeConstraints { (make) in
//            make.height.equalTo(frame.height/4)
//            make.left.equalTo(frame.width/2)
//        }
//        shopDetailLabel.snp.makeConstraints({ (make) in
//            make.height.equalTo(frame.height)
//            make.left.equalTo(frame.width/2)
//        })
    }
    
    func configure(text: String, image: UIImage) {
        self.shopImageView.image = image
        self.shopNameLabel.text = text
    }
    
    func roundEdge() {
        self.layer.cornerRadius = self.frame.size.width * 0.05
        self.clipsToBounds = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
