//
//  TutorialPageViewController.swift
//  aboon
//
//  Created by 原口和音 on 2018/09/10.
//  Copyright © 2018年 aboon. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class TutorialPageViewController: UIViewController {

    let page: Int
    let isLast: Bool
    
    init(page: Int, isLast: Bool) {
        self.page = page
        self.isLast = isLast
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let imageView = UIImageView(image: UIImage(named: "tutorial\(page.description)"))
        imageView.frame.size = CGSize(width: 320, height: 568)
        imageView.center = view.center
        view.backgroundColor = UIColor(hex: "FF5C5C")
        view.addSubview(imageView)
        
        if isLast {
            let finishButton = UIButton(type: .custom)
            finishButton.setTitle("はじめる", for: .normal)
            finishButton.setTitleColor(.white, for: .normal)
            finishButton.backgroundColor = UIColor(hex: "FFCA00", alpha: 0.5)
            finishButton.addTarget(self, action: #selector(finishTapped), for: .touchUpInside)
            
            view.addSubview(finishButton)
            finishButton.translatesAutoresizingMaskIntoConstraints = false
            finishButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
            finishButton.bottomAnchor.constraint(equalTo: imageView.bottomAnchor, constant: -10).isActive = true
            finishButton.widthAnchor.constraint(equalToConstant: 160).isActive = true
            finishButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        }
    }
    
    private let finishRelay = BehaviorRelay<Bool>(value: false)
    var finishObservable: Observable<Bool> { return finishRelay.asObservable() }
    
    @objc func finishTapped() {
        finishRelay.accept(true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
