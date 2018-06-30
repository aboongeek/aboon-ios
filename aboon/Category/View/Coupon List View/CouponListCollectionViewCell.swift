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
        //クーポンに紐付ける画像の初期化
        couponImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: frame.width, height: frame.height))
        addSubview(couponImageView!)
        //クーポンタイトルの初期化
        couponNameLabel = UILabel(frame: CGRect(x: 0, y: 0, width: frame.width, height: frame.height))
        couponNameLabel?.textAlignment = .left
        couponNameLabel?.textColor = .white
        couponNameLabel?.font = UIFont.boldSystemFont(ofSize: (couponNameLabel?.font.pointSize)!)
        couponNameLabel?.text = "nil"
        
        addSubview(couponNameLabel!)
        //クーポンの説明文の初期化
        couponDetailLabel = UILabel(frame: CGRect(x: 0, y: 0, width: frame.width, height: frame.height))
        couponDetailLabel?.textAlignment = .left
        couponDetailLabel?.textColor = .white
        couponDetailLabel?.font = UIFont.boldSystemFont(ofSize: (couponDetailLabel?.font.pointSize)!)
        couponDetailLabel?.text = "nil"
        
        addSubview((couponDetailLabel!))
        
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
