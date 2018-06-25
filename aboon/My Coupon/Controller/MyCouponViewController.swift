//
//  MyCouponViewController.swift
//  aboon
//
//  Created by 原口和音 on 2018/06/24.
//  Copyright © 2018 aboon. All rights reserved.
//

import UIKit
import SideMenu

class MyCouponViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "マイクーポン"
        
        let sideMenuController = UISideMenuNavigationController(rootViewController: MyMenuController())
        SideMenuManager.default.menuRightNavigationController = sideMenuController
        SideMenuManager.default.menuAddScreenEdgePanGesturesToPresent(toView: self.navigationController!.navigationBar)
        SideMenuManager.default.menuAddScreenEdgePanGesturesToPresent(toView: self.navigationController!.view)
        SideMenuManager.default.menuPresentMode = .menuSlideIn
        
        self.navigationItem.setRightBarButton(UIBarButtonItem(image: #imageLiteral(resourceName: "circle-user-7"), style: .plain, target: self, action: #selector(self.showMyMenu)), animated: true)
        
        let testLabel = UILabel(frame: CGRect(x: 0, y: 100, width: 100, height: 100))
        testLabel.text = "My Coupon"
        self.view.addSubview(testLabel)
        
        self.view.backgroundColor = .white
        
    }
    
    @objc func showMyMenu() {
        present(SideMenuManager.default.menuRightNavigationController!, animated: true, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
