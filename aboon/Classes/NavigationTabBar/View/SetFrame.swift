//
//  SetFrame.swift
//  aboon
//
//  Created by 原口和音 on 2018/07/09.
//  Copyright © 2018年 aboon. All rights reserved.
//

import UIKit

extension UIView {
    func setFrame (tabBar: UITabBar, navBar: NavigationBar) {
        let frameHeight = UIScreen.main.bounds.size.height - tabBar.frame.size.height - navBar.frame.size.height - UIApplication.shared.statusBarFrame.height
        let frameSize = CGSize(width: UIScreen.main.bounds.size.width, height: frameHeight)
        self.frame = CGRect(origin: frame.origin, size: frameSize)
    }
    
    func setFrame (navBar: NavigationBar) {
        let frameHeight = UIScreen.main.bounds.size.height - navBar.frame.size.height - UIApplication.shared.statusBarFrame.height
        let frameSize = CGSize(width: UIScreen.main.bounds.size.width, height: frameHeight)
        self.frame = CGRect(origin: frame.origin, size: frameSize)
    }
}
