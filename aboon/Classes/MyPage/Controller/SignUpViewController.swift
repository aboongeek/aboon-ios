//
//  SignUpViewController.swift
//  aboon
//
//  Created by 原口和音 on 2018/08/07.
//  Copyright © 2018年 aboon. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import RxSwift
import RxCocoa

class SignUpViewController: UIViewController {
    
    var signUpView: SignUpView!
    lazy var model = SignUpModel()
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        
        self.signUpView = SignUpView()
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    override func loadView() {
        self.view = signUpView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        signUpView.appendViews()
        
        
        signUpView.applyButton.addTarget(self, action: #selector(applyTapped), for: .touchUpInside)
        
    }
    
    @objc func applyTapped() {
        let confirmationAlert = UIAlertController(title: "登録", message: "この内容で登録しますか？", preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "登録する", style: .default, handler: {[weak self] (action: UIAlertAction!) in
            
            guard let `self` = self,
                let emailText = self.signUpView.emailTextField.text,
                let passwordText = self.signUpView.passwordTextField.text
                else { return }
            
            Auth.auth().createUser(withEmail: emailText, password: passwordText, completion:
                { [weak self] (FirUser, error) in
                    
                    guard let `self` = self,
                        let FirUser = FirUser,
                        let userNameText = self.signUpView.userNameTextField.text,
                        let gender = Gender(rawValue: self.signUpView.genderButton.selectedSegmentIndex)
                        else { return }
                    let dob = self.signUpView.dobPicker.date
                    
                    let user = User(userName: userNameText,
                                    email: emailText,
                                    dateOfBirth: dob,
                                    gender: gender,
                                    userId: FirUser.user.uid)
                    
                    self.model.addUser(user: user)
                    
                    Auth.auth().signIn(withEmail: emailText, password: passwordText, completion: { (_, error) in
                        if let error = error {
                            dLog(error)
                        } else {
                            self.dismiss(animated: true, completion: nil)
                        }
                    })
                })
            
        })
        
        let cancelAction = UIAlertAction(title: "キャンセル", style: .cancel, handler: nil)
        
        confirmationAlert.addAction(okAction)
        confirmationAlert.addAction(cancelAction)
        
        present(confirmationAlert, animated: true, completion: nil)

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
