//
//  MyMenuViewController.swift
//  aboon
//
//  Created by 原口和音 on 2018/06/25.
//  Copyright © 2018 aboon. All rights reserved.
//

import UIKit
import Firebase
import RxSwift
import RxCocoa

class MyMenuViewController: UIViewController {
    
    let disposeBag = DisposeBag()
    
    let model = MyMenuModel()
    lazy var myMenuView = MyMenuView()
    
    override func loadView() {
        self.view = myMenuView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        myMenuView.appendTableView()

        myMenuView.myMenuTableView.register(MyMenuTableViewCell.self, forCellReuseIdentifier: "MyMenuTableViewCell")
        myMenuView.myMenuTableView.delegate = self
        myMenuView.myMenuTableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        model.refreshUser()
        
        model
            .userName
            .asDriver(onErrorDriveWith: Driver.empty())
            .drive(onNext: { [weak self] userName in
                guard let `self` = self else { return }
                self.navigationItem.title = "こんにちは、\(userName)さん"
            })
            .disposed(by: disposeBag)        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension MyMenuViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.menulist.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyMenuTableViewCell", for: indexPath) as! MyMenuTableViewCell
        cell.menuLabel.text = model.menulist[indexPath.row]
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.row == 0 { //Sign In
            if model.user == nil {
                let signInViewController = SignInViewController()
                present(signInViewController, animated: true)
            } else {
                let alreadySignedInAlert = UIAlertController(title: "すでにログインしています", message: "あなたはすでにアカウントにログインされています。", preferredStyle: .alert)
                alreadySignedInAlert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                present(alreadySignedInAlert, animated: true)
            }
        } else if indexPath.row == 1 { //Sign Out
            do {
                try Auth.auth().signOut()
                model.refreshUser()

                let signedOutAlert = UIAlertController(title: "ログアウト", message: "ログアウトしました。", preferredStyle: .alert)
                signedOutAlert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                present(signedOutAlert, animated: true)
                
            } catch let signOutError as NSError {
                dLog(signOutError.userInfo)
            }
        } else if indexPath.row == 2 { //Contact
            let webViewController = WebViewController(url: URL(string: "https://www.aboon.jp/contact")!)
            present(webViewController, animated: true, completion: nil)
        }
    }
    
}
