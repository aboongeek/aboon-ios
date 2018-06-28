//
//  MyCouponViewController.swift
//  aboon
//
//  Created by 原口和音 on 2018/06/24.
//  Copyright © 2018 aboon. All rights reserved.
//

import UIKit

class MyCouponViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
                
        self.navigationItem.configureBarItems(title: "マイクーポン", navigationController: navigationController as! NavigationController)
        
        let testLabel = UILabel(frame: CGRect(x: 0, y: 100, width: 100, height: 100))
        testLabel.text = "My Coupon"
        self.view.addSubview(testLabel)
        
        self.view.backgroundColor = .white
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }

}
