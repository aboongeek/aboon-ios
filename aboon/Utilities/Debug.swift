//
//  Debug.swift
//  aboon
//
//  Created by AmamiYou on 2018/06/21.
//  Copyright © 2018年 aboon. All rights reserved.
//

import Foundation

func dLog(_ obj: Any?,
              function: String = #function,
              line: Int = #line) {
    #if DEBUG
    if let obj = obj {
        print("[Function:\(function) Line:\(line)] : \(obj)")
    } else {
        print("[Function:\(function) Line:\(line)]")
    }
    #endif
}
