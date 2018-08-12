//
//  SignUpView.swift
//  aboon
//
//  Created by 原口和音 on 2018/08/07.
//  Copyright © 2018年 aboon. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class SignUpView: UIView {

    let userNameLabel = UILabel()
    let userNameTextField = UITextField()
    let emailLabel = UILabel()
    let emailTextField = UITextField()
    let passwordLabel = UILabel()
    let passwordTextField = UITextField()
    let dobLabel = UILabel()
    let dobSelecter = UITextField()
    let dobPicker = UIDatePicker()
    let genderLabel = UILabel()
    let genderButton : UISegmentedControl
    let genderButtonMale = UIButton()
    let genderButtonFemale = UIButton()
    let genderStackView = UIStackView()
    let applyButton = UIButton()
    let stackView: UIStackView
    
    override init(frame: CGRect) {
        
        userNameLabel.text = "ユーザーネーム"

        userNameTextField.text = "aboon"
        
        emailLabel.text = "メールアドレス"
        
        emailTextField.text = "aboon@aboon.jp"
        
        passwordLabel.text = "パスワード"
        
        passwordTextField.text = "パスワードを入力してください"
        
        dobLabel.text = "生年月日"
        
        genderLabel.text = "性別"
        
        genderButton = UISegmentedControl(items: ["男性", "女性"])
        
        applyButton.setTitle("登録", for: .normal)
        
        stackView = UIStackView(arrangedSubviews: [userNameLabel, userNameTextField, emailLabel, emailTextField, passwordLabel, passwordTextField, dobLabel, dobPicker, genderLabel, genderButton, applyButton])
        stackView.axis = .vertical
        stackView.alignment = .center
        
        super.init(frame: frame)
        
        backgroundColor = .white
        
        setUpDOBPicker()
    
    }
    
    func appendViews() {
        addSubview(stackView)
    }
    
    let dateFormat = DateFormatter()
    
    func setUpDOBPicker() {
        
        let defaultDate = Date(timeIntervalSince1970: 0)
        
        dateFormat.dateFormat = "yyyy年MM月dd日"
        dobSelecter.text = dateFormat.string(from: defaultDate)
        
        dobPicker.datePickerMode = UIDatePickerMode.date
        dobSelecter.inputView = dobPicker
        
        let spaceBarBtn = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: self, action: nil)
        
        let toolBarBtn = UIBarButtonItem(title: "完了", style: .done, target: self, action: #selector(doneBtnPushed))
        
        let pickerToolBar = UIToolbar()
        pickerToolBar.items = [spaceBarBtn,toolBarBtn]
        dobSelecter.inputAccessoryView = pickerToolBar
        
    }
    
    @objc func doneBtnPushed () {
        dobSelecter.text = dateFormat.string(from: dobPicker.date)
        self.endEditing(true)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        //autolayout
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
