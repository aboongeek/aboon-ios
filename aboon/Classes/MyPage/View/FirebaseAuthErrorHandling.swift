//
//  FirebaseAuthErrorHandling.swift
//  aboon
//
//  Created by 原口和音 on 2018/08/19.
//  Copyright © 2018年 aboon. All rights reserved.
//

import Foundation
import Firebase

class AuthErrorHandling {
    static func showErrorAlert(from error: NSError) -> UIAlertController {
        var message: String {
            if let errCode = AuthErrorCode(rawValue: error.code) {
                switch errCode {
                case .invalidEmail:
                    return "メールアドレスが正しくありません。"
                case .emailAlreadyInUse:
                    return "このメールアドレスは既に使われています。"
                case .weakPassword:
                    return "パスワードが脆弱です。"
                case .wrongPassword:
                    return "パスワードが間違っています。"
                case .userDisabled:
                    return "このアカウントは無効です。詳細はhttps://www.aboon.jpよりお問い合わせください。"
                case .userNotFound:
                    return "ユーザーが見つかりません。メールアドレスが正しいか確認してください。"
                default:
                    return "エラーが発生しました。"
                }
            }
            return ""
        }
        
        dLog(error.userInfo)
        
        let alert = UIAlertController(title: "エラー", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        
        return alert
    }
    
}
