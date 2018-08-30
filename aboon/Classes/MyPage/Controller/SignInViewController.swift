//
//  SignInViewController.swift
//  aboon
//
//  Created by 原口和音 on 2018/06/24.
//  Copyright © 2018 aboon. All rights reserved.
//

import UIKit
import Firebase
import RxSwift
import RxCocoa

class SignInViewController: UIViewController {
    
    let disposeBag = DisposeBag()
    
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
        
        signInView
            .notifySignIn
            .subscribe(onNext: { [weak self] (signInInfo) in
                guard let `self` = self else { return }

                if signInInfo.isTapped {
                    
                    let activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .gray)
                    activityIndicator.frame = self.signInView.frame
                    self.signInView.view?.addSubview(activityIndicator)
                    activityIndicator.startAnimating()
                    
                    Auth.auth().signIn(withEmail: signInInfo.email, password: signInInfo.password, completion: { (result, error) in
                        if error != nil {
                            self.present(AuthErrorHandling.showErrorAlert(from: error! as NSError), animated: true, completion: nil)
                            activityIndicator.stopAnimating()
                        } else {
                            self.dismiss(animated: true, completion: nil)
                        }
                    })
                    
                }
            })
            .disposed(by: disposeBag)
        
        signInView
            .notifySignUp
            .subscribe(onNext: { [weak self] (isTapped) in
                guard let `self` = self else { return }
                if isTapped {
                    let signUpViewController = SignUpViewController()
                    self.present(signUpViewController, animated: true, completion: nil)
                }
            })
            .disposed(by: disposeBag)
        
        signInView
            .notifyDismiss
            .subscribe(onNext: { [weak self] (isTapped) in
                guard let `self` = self else { return }
                if isTapped {
                    self.dismiss(animated: true, completion: nil)
                }
            })
            .disposed(by: disposeBag)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
