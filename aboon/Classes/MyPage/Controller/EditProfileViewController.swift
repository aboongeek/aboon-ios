//
//  EditProfileViewController.swift
//  aboon
//
//  Created by 原口和音 on 2018/06/24.
//  Copyright © 2018 aboon. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import Firebase
import FirebaseAuth

class EditProfileViewController: UIViewController {
    
    let disposeBag = DisposeBag()
    
    lazy var editProfileView = EditProfileView()
    lazy var model = EditProfileModel()
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    override func loadView() {
        self.view = editProfileView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var currentUser: User!
        
        model
            .currentUser
            .subscribe(onNext: { [weak self] (user) in
                guard let `self` = self else { return }
                currentUser = user
                self.editProfileView.configure(user: user)
            })
            .disposed(by: disposeBag)
        
        editProfileView
            .doneBtnObservable
            .subscribe { [weak self] in
                guard let `self` = self else { return }
                let confirmationAlertController = UIAlertController(title: "変更", message: "この内容で変更しますか？", preferredStyle: .alert)
                
                let okAction = UIAlertAction(title: "変更する", style: .default, handler: {[weak self] (action: UIAlertAction!) in
                   
                    guard let `self` = self,
                        let newUserName = self.editProfileView.userNameTextField.text,
                        let newGender = Gender(rawValue: self.editProfileView.genderButton.selectedSegmentIndex)
                        else { return }
                    let newDob = self.editProfileView.dobPicker.date
                    
                    let userUpdated = User(userName: newUserName,
                                           email: currentUser.email,
                                           dateOfBirth: newDob,
                                           gender: newGender,
                                           userId: currentUser.userId)
                    
                    self.model.updateUser(user: userUpdated)
                    
                    
                })
                
                let cancelAction = UIAlertAction(title: "キャンセル", style: .default, handler: {[weak self] (action: UIAlertAction!) in
                    guard let `self` = self else { return }
                    self.dismiss(animated: true, completion: nil)
                })
                
                confirmationAlertController.addAction(okAction)
                confirmationAlertController.addAction(cancelAction)
                
                self.present(confirmationAlertController, animated: true, completion: nil)
            }
            .disposed(by: disposeBag)
        
//        self.view.backgroundColor = .white
//        let label = UILabel(frame: CGRect(x: 0,
//                                          y: 0,
//                                          width: 100,
//                                          height: 50)
//        )
//        label.text = "EditProfileViewController"
//        self.view.addSubview(label)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
