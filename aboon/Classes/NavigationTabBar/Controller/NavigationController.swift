//
//  NavigationController.swift
//  aboon
//
//  Created by 原口和音 on 2018/06/25.
//  Copyright © 2018 aboon. All rights reserved.
//

import UIKit
import SideMenu

class NavigationController: UINavigationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let sideMenuController = UISideMenuNavigationController(rootViewController: MyMenuViewController())
        sideMenuController.navigationBar.setColor()
        SideMenuManager.default.menuRightNavigationController = sideMenuController
        SideMenuManager.default.menuAddPanGestureToPresent(toView: self.navigationBar)
        SideMenuManager.default.menuAddScreenEdgePanGesturesToPresent(toView: self.view, forMenu: .right )
        SideMenuManager.default.menuPresentMode = .menuSlideIn
    }
    
    
    @objc public func showMyMenu() {
        present(SideMenuManager.default.menuRightNavigationController!, animated: true, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }

}
