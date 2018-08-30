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
    
    var view: UIView?
    
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var dobSelecter: UITextField!
    @IBOutlet weak var genderButton: UISegmentedControl!
    @IBOutlet weak var errorLabel: UILabel!
    
    var datePicker: UIDatePicker!
    
    let dateFormatter = DateFormatter()
    
    typealias SignUpInfo = (userName: String?, email: String?, password: String?, dob: Date?, gender: Gender?)
    
    private let notifySignUpRelay = BehaviorRelay<Bool>(value: false)
    var notifySignUp: Observable<Bool> { return notifySignUpRelay.asObservable()}
    
    private let notifySignUpInfoSubject = PublishSubject<SignUpInfo>()
    var notifySignUpInfo: Observable<SignUpInfo> { return notifySignUpInfoSubject.asObservable()}
    
    private let notifyDismissRelay = BehaviorRelay<Bool>(value: false)
    var notifyDismiss: Observable<Bool> { return notifyDismissRelay.asObservable()}
    
    private let notifyTOSRelay = BehaviorRelay<Bool>(value: false)
    var notifyTOS: Observable<Bool> { return notifyTOSRelay.asObservable()}
    
    private let notifyPPRelay = BehaviorRelay<Bool>(value: false)
    var notifyPP: Observable<Bool> { return notifyPPRelay.asObservable()}
    
    @IBAction func signUpTapped(_ sender: Any) {
        notifySignUpRelay.accept(true)
        
        guard let userName = userNameTextField.text,
            let email = emailTextField.text,
            let password = passwordTextField.text,
            let dobString = dobSelecter.text,
            let dob = dateFormatter.date(from: dobString)
            else { return }
        
        let gender = Gender(rawValue: genderButton.selectedSegmentIndex)
        
        if !userName.isEmpty && !email.isEmpty && !password.isEmpty && genderButton.selectedSegmentIndex != UISegmentedControlNoSegment {
            notifySignUpInfoSubject.onNext((userName: userName, email: email, password: password, dob: dob, gender: gender))
        } else {
            errorLabel.isHidden = false
        }
    }
    
    @IBAction func dismissTapped(_ sender: Any) {
        notifyDismissRelay.accept(true)
    }
    
    @IBAction func tosTapped(_ sender: Any) {
        notifyTOSRelay.accept(true)
    }
    
    @IBAction func ppTapped(_ sender: Any) {
        notifyPPRelay.accept(true)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.view = UINib(nibName: "SignUpView", bundle: nil).instantiate(withOwner: self, options: nil).first as? UIView
        guard let view = view else {
            return
        }
        addSubview(view)
        
        // カスタムViewのサイズを自分自身と同じサイズにする
        view.translatesAutoresizingMaskIntoConstraints = false
        view.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        view.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        view.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        view.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        
        setUpDOBPicker()

    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

extension SignUpView {
    
    func setUpDOBPicker() {
        
        dateFormatter.dateFormat  = "yyyy年MM月dd日"

        
        let spaceBarBtn = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: self, action: nil)
        
        let toolBarBtn = UIBarButtonItem(title: "完了", style: .done, target: self, action: #selector(dobDoneBtnPushed))
        
        let pickerToolBar = UIToolbar()
        pickerToolBar.sizeToFit()
        pickerToolBar.items = [spaceBarBtn,toolBarBtn]
        dobSelecter.inputAccessoryView = pickerToolBar
        
        let defaultDate = Date()
        datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        datePicker.date = defaultDate
        datePicker.addTarget(self, action: #selector(datePickerValueChanged(_:)), for: .valueChanged)

        dobSelecter.text = dateFormatter.string(from: defaultDate)
        dobSelecter.inputView = datePicker
    }
    
    @IBAction func dobSelecterSelected(_ sender: UITextField) {
        sender.inputView = datePicker
    }
    
    @objc func datePickerValueChanged(_ sender: UIDatePicker) {
        dobSelecter.text = dateFormatter.string(from: sender.date)
    }
    
    @objc func dobDoneBtnPushed () {
        dobSelecter.text = dateFormatter.string(from: datePicker.date)
        dobSelecter.resignFirstResponder()
    }
}
