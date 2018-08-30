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
    
    var view: UIView?
    
    @IBOutlet weak var signInLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordLabel: UILabel!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signInButton: UIButton!
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var dismissButton: UIButton!
    @IBOutlet weak var errorLabel: UILabel!
    
    typealias SignInInfo = (isTapped: Bool, email: String, password: String)
    
    private let notifySignInRelay = BehaviorRelay<SignInInfo>(value: (isTapped: false, email: "", password: ""))
    var notifySignIn: Observable<SignInInfo> { return notifySignInRelay.asObservable()}
    
    private let notifySignUpRelay = BehaviorRelay<Bool>(value: false)
    var notifySignUp: Observable<Bool> { return notifySignUpRelay.asObservable()}
    
    private let notifyDismissRelay = BehaviorRelay<Bool>(value: false)
    var notifyDismiss: Observable<Bool> { return notifyDismissRelay.asObservable()}
    
    @IBAction func signInTapped(_ sender: Any) {
        guard let email = emailTextField.text, let password = passwordTextField.text else { return }
        if !email.isEmpty && !password.isEmpty {
            let signInInfo = (true, email, password)
            notifySignInRelay.accept(signInInfo)
        } else {
            errorLabel.isHidden = false
        }
    }
    
    @IBAction func signUpTapped(_ sender: Any) {
        notifySignUpRelay.accept(true)
    }
    
    @IBAction func dismissTapped(_ sender: Any) {
        notifyDismissRelay.accept(true)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.view = UINib(nibName: "SignInView", bundle: nil).instantiate(withOwner: self, options: nil).first as? UIView
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
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
   
}
