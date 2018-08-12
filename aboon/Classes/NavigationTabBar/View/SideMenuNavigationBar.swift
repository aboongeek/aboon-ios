//
//  SideMenuNavigationBar.swift
//  aboon
//
//  Created by EXIST on 2018/07/22.
//  Copyright © 2018年 aboon. All rights reserved.
//

import Foundation
import SideMenu

extension UINavigationBar {
    func setColor() {
        self.barTintColor = UIColor(hex: "FF5C5C")
        self.isTranslucent = false
        self.titleTextAttributes = [NSAttributedStringKey.foregroundColor : UIColor.white]
    }
}
