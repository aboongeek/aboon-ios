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
        
        self.navigationItem.title = "マイクーポン"
        
        let myMenuModel = MyMenuModel()
        self.navigationItem.setRightBarButton(UIBarButtonItem(image: #imageLiteral(resourceName: "circle-user-7"), style: .plain, target: myMenuModel, action: #selector(MyMenuModel.showMyMenu)), animated: true)
        
        let testLabel = UILabel(frame: CGRect(x: 0, y: 100, width: 100, height: 100))
        testLabel.text = "My Coupon"
        self.view.addSubview(testLabel)
        
        self.view.backgroundColor = .white
        
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
