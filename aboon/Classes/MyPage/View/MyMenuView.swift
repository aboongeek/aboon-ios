//
//  MyMenuView.swift
//  aboon
//
//  Created by EXIST on 2018/07/21.
//  Copyright © 2018年 aboon. All rights reserved.
//

import UIKit

class MyMenuView: UIView {
    var myMenuTableView: UITableView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.frame = UIScreen.main.bounds
        self.backgroundColor = .white
    }
    
    public func appendTableView() {
        myMenuTableView = UITableView(frame: self.bounds, style: .plain)
        myMenuTableView.isScrollEnabled = false
        myMenuTableView.separatorStyle = .none
        self.addSubview(myMenuTableView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
