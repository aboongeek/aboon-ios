//
//  NavigationItem.swift
//  aboon
//
//  Created by 原口和音 on 2018/06/26.
//  Copyright © 2018 aboon. All rights reserved.
//

import UIKit

extension UINavigationItem {
    
     func configureBarItems (title: String, navigationController: NavigationController) {
        
        self.title = title
        self.setRightBarButton(UIBarButtonItem(image: R.image.user(), style: .plain, target: navigationController, action: #selector(navigationController.showMyMenu)), animated: true)
    
    }
    
}
