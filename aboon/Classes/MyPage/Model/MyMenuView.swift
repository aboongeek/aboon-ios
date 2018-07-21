//
//  MyMenuView.swift
//  aboon
//
//  Created by EXIST on 2018/07/21.
//  Copyright © 2018年 aboon. All rights reserved.
//

import UIKit

class MyMenuView: UIView {
    var myMenuTableView: MyMenuTableView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.frame = UIScreen.main.bounds
    }
    
    public func appendTableView(_ tableView: UITableView) {
        self.addSubview(tableView)
        dLog("MyMenuTableView Appended")
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func createTableView() -> MyMenuTableView {
        myMenuTableView = MyMenuTableView(frame: self.bounds, style: UITableViewStyle.plain)
        return myMenuTableView
    }
}
