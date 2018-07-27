//
//  MyMenuTableViewCell.swift
//  aboon
//
//  Created by EXIST on 2018/07/21.
//  Copyright © 2018年 aboon. All rights reserved.
//

import UIKit

class MyMenuTableViewCell: UITableViewCell {
    var menuLabel: UILabel!
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        menuLabel = UILabel(frame: CGRect(
            x: 0,
            y: 0,
            width: self.frame.width,
            height: self.frame.height)
        )
        menuLabel.font = UIFont(name: "Roboto",
                                 size: menuLabel.font.pointSize)
        menuLabel.textColor = .black
        
        self.addSubview(menuLabel)
        
        //set constraints
        self.updateConstraints()
        
    }
    override func updateConstraints() {
        super.updateConstraints()
        //変更がある場合はここに追加
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


