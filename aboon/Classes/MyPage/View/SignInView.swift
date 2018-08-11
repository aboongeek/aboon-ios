//
//  SignInView.swift
//  aboon
//
//  Created by 原口和音 on 2018/08/09.
//  Copyright © 2018年 aboon. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class SignInView: UIView {

    let emailLabel = UILabel()
    let emailTextField = UITextField()
    let passwordLabel = UILabel()
    let passwordTextField = UITextField()
    let signInButton = UIButton()
    let signUpButton = UIButton()
    let stackView: UIStackView
    
    override init(frame: CGRect) {
        emailLabel.text = "メールアドレス"
        emailTextField.text = "aboon@aboon.jp"
        passwordLabel.text = "パスワード"
        passwordTextField.text = "パスワードを入力してください"
        
        signUpButton.setTitle("新規登録はこちら", for: .normal)
        
        signInButton.setTitle("ログイン", for: .normal)
        
        stackView = UIStackView(arrangedSubviews: [emailLabel, emailTextField, passwordLabel, passwordTextField, signInButton, signUpButton])
        
        super.init(frame: frame)
        
        self.backgroundColor = .white
        
    }
    
    func appendSubviews() {
        addSubview(stackView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
