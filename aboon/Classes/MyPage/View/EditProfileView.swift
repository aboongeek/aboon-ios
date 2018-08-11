//
//  EditProfileView.swift
//  aboon
//
//  Created by 原口和音 on 2018/08/09.
//  Copyright © 2018年 aboon. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class EditProfileView: UIView {

    let userNameLabel = UILabel()
    let userNameTextField = UITextField()
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
        
        userNameTextField.text = ""
        
        dobLabel.text = "生年月日"
        
        genderLabel.text = "性別"
        
        genderButton = UISegmentedControl(items: ["男性", "女性"])
        
        applyButton.setTitle("変更", for: .normal)
        
        stackView = UIStackView(arrangedSubviews: [userNameLabel, userNameTextField, dobLabel, dobPicker, genderLabel, genderButton, applyButton])
        stackView.axis = .vertical
        stackView.alignment = .center
        
        super.init(frame: frame)
        
        setUpDOBPicker()
        
    }
    
    func appendViews() {
        addSubview(stackView)
    }
    
    let defaultDate = Date(timeIntervalSince1970: 0)
    let dateFormat = DateFormatter()
    
    func setUpDOBPicker() {
        
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
    
    private let doneBtnSubject = PublishSubject<Bool>()
    var doneBtnObservable: Observable<Bool> { return doneBtnSubject.asObservable() }
    
    @objc func doneBtnPushed () {
        doneBtnSubject.onCompleted()
    }
    
    func configure(user: User) {
        userNameTextField.text = user.userName
        dobPicker.date = user.dateOfBirth
        dobSelecter.text = dateFormat.string(from: user.dateOfBirth)
        genderButton.selectedSegmentIndex = user.gender.rawValue
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        //autolayout
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
