//
//  SignUpViewController.swift
//  aboon
//
//  Created by 原口和音 on 2018/08/07.
//  Copyright © 2018年 aboon. All rights reserved.
//

import UIKit
import Firebase
import RxSwift
import RxCocoa

class SignUpViewController: UIViewController {
    
    let disposeBag = DisposeBag()
    
    var signUpView: SignUpView
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
        
        signUpView
            .notifySignUp
            .asDriver(onErrorDriveWith: Driver.empty())
            .drive(onNext: { [weak self] isTapped in
                guard let `self` = self else { return }
                if isTapped {
                    self.signUpView
                        .notifySignUpInfo
                        .asDriver(onErrorDriveWith: Driver.empty())
                        .drive(onNext: { signUpInfo in
                            let confirmationAlert = UIAlertController(title: "登録", message: "この内容で登録しますか？「規約に同意し登録する」を押した時点で利用規約、プライバシーポリシーに同意したものとみなされます。", preferredStyle: .alert)
                            
                            let okAction = UIAlertAction(title: "規約に同意し登録する", style: .default, handler: {[weak self] (action: UIAlertAction!) in
                                
                                guard let `self` = self,
                                    let emailText = signUpInfo.email,
                                    let passwordText = signUpInfo.password
                                    else { return }
                                
                                let activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .gray)
                                activityIndicator.frame = self.signUpView.frame
                                self.signUpView.view?.addSubview(activityIndicator)
                                activityIndicator.startAnimating()
                                
                                Auth.auth().createUser(withEmail: emailText, password: passwordText, completion:
                                    { [weak self] (FirUser, error) in
                                        
                                        guard let `self` = self,
                                            let FirUser = FirUser,
                                            let userNameText = signUpInfo.userName,
                                            let gender = signUpInfo.gender,
                                            let dob = signUpInfo.dob
                                            else { return }
                                        
                                        if let error = error {
                                            self.present(AuthErrorHandling.showErrorAlert(from: error as NSError), animated: true, completion: nil)
                                            activityIndicator.stopAnimating()
                                            
                                        } else {
                                            
                                            let user = User(userName: userNameText,
                                                            email: emailText,
                                                            dateOfBirth: dob,
                                                            gender: gender,
                                                            userId: FirUser.user.uid)
                                            
                                            self.model.addUser(user: user)
                                            
                                            let changeRequest = FirUser.user.createProfileChangeRequest()
                                            changeRequest.displayName = user.userName
                                            changeRequest.commitChanges(completion: { (error) in
                                                Auth.auth().signIn(withEmail: emailText, password: passwordText, completion: { (_, error) in
                                                    if let error = error {
                                                        self.present(AuthErrorHandling.showErrorAlert(from: error as NSError), animated: true, completion: nil)
                                                        activityIndicator.stopAnimating()
                                                    } else {
                                                        if let presentingVC = self.presentingViewController {
                                                            self.dismiss(animated: true, completion: nil)
                                                            presentingVC.dismiss(animated: true, completion: nil)
                                                        } else {
                                                            self.dismiss(animated: true, completion: nil)
                                                        }
                                                    }
                                                })
                                            })
                                        }
                                        
                                })
                                
                            })
                            
                            let cancelAction = UIAlertAction(title: "キャンセル", style: .cancel, handler: nil)
                            
                            confirmationAlert.addAction(okAction)
                            confirmationAlert.addAction(cancelAction)
                            
                            self.present(confirmationAlert, animated: true, completion: nil)
                        })
                        .disposed(by: self.disposeBag)
                }
            })
            .disposed(by: disposeBag)
        
        signUpView
            .notifyDismiss
            .asDriver(onErrorDriveWith: Driver.empty())
            .drive(onNext: { [weak self] isTapped in
                guard let `self` = self else { return }
                if isTapped {
                    self.dismiss(animated: true, completion: nil)
                }
            })
            .disposed(by: disposeBag)
        
        signUpView
            .notifyTOS
            .asDriver(onErrorDriveWith: Driver.empty())
            .drive(onNext: { [weak self] isTapped in
                guard let `self` = self else { return }
                if isTapped {
                    guard let url = URL(string: "https://www.aboon.jp/terms-of-service") else { return }
                    self.present(WebViewController(url: url), animated: true, completion: nil)
                }
            })
            .disposed(by: disposeBag)
        
        signUpView
            .notifyPP
            .asDriver(onErrorDriveWith: Driver.empty())
            .drive(onNext: { [weak self] isTapped in
                guard let `self` = self else { return }
                if isTapped {
                    guard let url = URL(string: "https://www.aboon.jp/privacy") else { return }
                    self.present(WebViewController(url: url), animated: true, completion: nil)
                }
            })
            .disposed(by: disposeBag)

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
