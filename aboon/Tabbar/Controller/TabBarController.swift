//
//  TabBarController.swift
//  aboon
//
//  Created by 原口和音 on 2018/06/23.
//  Copyright © 2018 aboon. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        addChildViewControllers()
    }
    
    private func addChildViewControllers () {
        
        let categoryNavigationController = NavigationController(rootViewController: CategoryViewController())
        let myCouponNavigationController = NavigationController(rootViewController: MyCouponViewController())
        
        categoryNavigationController.tabBarItem.image = UIImage(named: "home-7.png")
        categoryNavigationController.title = "カテゴリ"
        
        myCouponNavigationController.tabBarItem.image = UIImage(named: "wallet-7.png")
        myCouponNavigationController.title = "所持クーポン"
        
        setViewControllers([categoryNavigationController, myCouponNavigationController], animated: false)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
