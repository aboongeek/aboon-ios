//
//  TabBarController.swift
//  aboon
//
//  Created by 原口和音 on 2018/06/23.
//  Copyright © 2018 aboon. All rights reserved.
//

import UIKit
import Firebase

class TabBarController: UITabBarController {

    let isInvited: Bool
    let roomId: String?
    
    init(isInvited: Bool, roomId: String?) {
        self.isInvited = isInvited
        self.roomId = roomId
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.delegate = self
        self.tabBar.isTranslucent = false
        addChildViewControllers()
    }
    
    private func addChildViewControllers () {
        
        let homeNavigationController = NavigationController(navigationBarClass: NavigationBar.self, toolbarClass: nil)
        let myCouponNavigationController = NavigationController(navigationBarClass: NavigationBar.self, toolbarClass: nil)
        
        homeNavigationController.viewControllers = [ShopListViewController()]
        myCouponNavigationController.viewControllers = [MyCouponListViewController()]
        
        homeNavigationController.tabBarItem.image = R.image.home7()
        myCouponNavigationController.tabBarItem.image = R.image.wallet7()
        
        setViewControllers([homeNavigationController, myCouponNavigationController], animated: false)
        
        if isInvited {
            self.selectedIndex = 1
            myCouponNavigationController.pushViewController(CouponRoomViewController(withJustRoomId: self.roomId!), animated: false)
            myCouponNavigationController.topViewController?.hidesBottomBarWhenPushed = true
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension TabBarController: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        if tabBarController.selectedIndex == 1 {
            if Auth.auth().currentUser == nil {
                self.present(SignInViewController(), animated: true)
            }
        }
    }
}
