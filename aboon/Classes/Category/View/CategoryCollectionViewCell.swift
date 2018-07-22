//
//  CategoryCollectionViewCell.swift
//  aboon
//
//  Created by 原口和音 on 2018/06/26.
//  Copyright © 2018 aboon. All rights reserved.
//

import UIKit

class CategoryCollectionViewCell: UICollectionViewCell {
    
    let textLabel: UILabel
    let backGroundImageView : UIImageView
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .black
        
        backGroundImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: frame.width, height: frame.height))
        backGroundImageView?.alpha = 0.7
        addSubview(backGroundImageView!)

        textLabel = UILabel(frame: CGRect(x: 0, y: 0, width: frame.width, height: frame.height))
        textLabel?.textAlignment = .center
        textLabel?.textColor = .white
        textLabel?.font = UIFont.boldSystemFont(ofSize: (textLabel?.font.pointSize)!)
        textLabel?.text = "nil"
        addSubview(textLabel!)
        roundEdge()
    }
    
    func configure(text: String, image: UIImage) {
        self.textLabel.text = text
        self.backGroundImageView.image = image
    }
    
    func roundEdge () {
        self.layer.cornerRadius = self.frame.size.width * 0.1
        self.clipsToBounds = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
