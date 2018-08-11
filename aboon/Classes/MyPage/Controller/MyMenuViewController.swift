//
//  MyMenuViewController.swift
//  aboon
//
//  Created by 原口和音 on 2018/06/25.
//  Copyright © 2018 aboon. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

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
        menuTableview.dataSource = self
        
        (self.view as! MyMenuView).appendTableView(menuTableview)
        
        self.navigationItem.configureBarItems(title: "こんにちは、\(model.userName)さん", navigationController: navigationController)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension MyMenuViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.menulist.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyMenuTableViewCell", for: indexPath) as! MyMenuTableViewCell
        cell.menuLabel.text = model.menulist[indexPath.row]
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let navigationController = navigationController else { return }
        
        if indexPath.row == 0 {
            if model.user != nil {
                let editProfileViewcontroller = EditProfileViewController()
                navigationController.pushViewController(editProfileViewcontroller, animated: true)
            } else {
                let signUpViewController = SignUpViewController()
                present(signUpViewController, animated: true) {
                    let editProfileViewcontroller = EditProfileViewController()
                    navigationController.pushViewController(editProfileViewcontroller, animated: true)
                }
            }
        } else if indexPath.row == 1 {
//            let editProfileViewcontroller = EditProfileViewController()
//            navigationController.pushViewController(editProfileViewcontroller, animated: true)
        }
    }
    
}
