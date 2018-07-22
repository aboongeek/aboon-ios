//
//  MyMenuViewController.swift
//  aboon
//
//  Created by 原口和音 on 2018/06/25.
//  Copyright © 2018 aboon. All rights reserved.
//

import UIKit

class MyMenuViewController: UIViewController {
    let model = MyMenuModel()
    
    
    override func loadView() {
        self.view = MyMenuView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        
        let menuTableview = (self.view as! MyMenuView).createTableView()
        menuTableview.register(MyMenuTableViewCell.self, forCellReuseIdentifier: "MyMenuTableViewCell")
        menuTableview.isScrollEnabled = false
        menuTableview.delegate = self
        menuTableview.dataSource = model as! UITableViewDataSource
        
        (self.view as! MyMenuView).appendTableView(menuTableview)
        
        self.navigationItem.configureBarItems(title: "こんにちは、\(model.user.name)さん", navigationController: navigationController)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension MyMenuViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            let signInViewController = SignInViewController()
            self.navigationController?.pushViewController(signInViewController, animated: true)
        } else if indexPath.row == 1 {
            let editProfileViewcontroller = EditProfileViewController()
            self.navigationController?.pushViewController(editProfileViewcontroller, animated: true)
        }
    }
}
