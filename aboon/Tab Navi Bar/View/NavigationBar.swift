//
//  NavigationBar.swift
//  aboon
//
//  Created by 原口和音 on 2018/06/25.
//  Copyright © 2018 aboon. All rights reserved.
//

import UIKit

class NavigationBar: UINavigationBar {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.tintColor = .white
        self.barTintColor = UIColor(hex: "FF7856")
        self.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
        self.isTranslucent = false
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
