//
//  SignInViewController.swift
//  aboon
//
//  Created by 原口和音 on 2018/06/24.
//  Copyright © 2018 aboon. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class SignInViewController: UIViewController {
    
    var signInView: SignInView
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        signInView = SignInView()
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    override func loadView() {
        self.view = signInView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        signInView.appendSubviews()
        signInView.signUpButton.addTarget(self, action: #selector(signUpTapped), for: .touchUpInside)
        signInView.signInButton.addTarget(self, action: #selector(signInTapped), for: .touchUpInside)
        
    }
    
    @objc func signUpTapped() {
        let signUpViewController = SignUpViewController()
        present(signUpViewController, animated: true, completion: nil)
    }
    
    @objc func signInTapped() {
        guard let emailText = signInView.emailTextField.text, let passwordText = signInView.passwordTextField.text else { return }
        Auth.auth().signIn(withEmail: emailText, password: passwordText) { (_, error) in
            if let error = error {
                //エラー処理
                dLog(error)
            } else {
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
