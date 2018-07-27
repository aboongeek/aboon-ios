//
//  MyMenuModel.swift
//  aboon
//
//  Created by EXIST on 2018/07/21.
//  Copyright © 2018年 aboon. All rights reserved.
//



class MyMenuModel: NSObject {
    var user = TestUser()
    let menulist = ["アカウント編集", "カスタマーサービス"]
}


extension MyMenuModel: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menulist.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyMenuTableViewCell", for: indexPath) as! MyMenuTableViewCell
        cell.menuLabel.text = menulist[indexPath.row]
        return cell
    }
}
