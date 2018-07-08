//
//  MyMenuController.swift
//  aboon
//
//  Created by 原口和音 on 2018/06/25.
//  Copyright © 2018 aboon. All rights reserved.
//

import UIKit

class MyMenuController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let testLabel = UILabel(frame: CGRect(x: 0, y: 100, width: 100, height: 100))
        testLabel.text = "My Menu"
        self.view.addSubview(testLabel)
        
        self.view.backgroundColor = .white

        // Do any additional setup after loading the view.
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
