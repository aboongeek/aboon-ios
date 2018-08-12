//
//  User.swift
//  aboon
//
//  Created by 原口和音 on 2018/08/07.
//  Copyright © 2018年 aboon. All rights reserved.
//

import Foundation

enum Gender: Int {
    case male = 0
    case female = 1
}

struct User {
    var userName: String
    var email: String
    var dateOfBirth: Date
    var gender: Gender
    var userId: String
}
