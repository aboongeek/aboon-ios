//
//  User.swift
//  aboon
//
//  Created by EXIST on 2018/07/21.
//  Copyright © 2018年 aboon. All rights reserved.
//



enum Gender: Int {
    case man = 0
    case women = 1
}
class TestUser {
    var name = "aboon"
    var dateOfBirth = Date()
    var gender = Gender.man
}
