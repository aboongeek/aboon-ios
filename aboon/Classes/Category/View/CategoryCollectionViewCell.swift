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
        backGroundImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: frame.width, height: frame.height))
        backGroundImageView.alpha = 0.7
        backGroundImageView.translatesAutoresizingMaskIntoConstraints = false

        textLabel = UILabel(frame: CGRect(x: 0, y: 0, width: frame.width, height: frame.height))
        textLabel.textAlignment = .center
        textLabel.textColor = .white
        textLabel.font = UIFont.boldSystemFont(ofSize: textLabel.font.pointSize)
        textLabel.text = ""
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        
        super.init(frame: frame)
        
        addSubview(backGroundImageView)
        backGroundImageView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        backGroundImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        backGroundImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        backGroundImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        
        addSubview(textLabel)
        textLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        textLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        
        self.backgroundColor = .black
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
