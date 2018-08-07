//
//  ShopDetailViewController.swift
//  aboon
//
//  Created by 原口和音 on 2018/06/24.
//  Copyright © 2018 aboon. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ShopDetailViewController: UIViewController {

    let disposeBag = DisposeBag()
    
    let model: ShopDetailModel
    
    private let titleName: String
    
    init(ofShop shop: ShopSummary) {
        self.model = ShopDetailModel(shopRef: shop.documentRef, storageRef: shop.storageRef)
        self.titleName = "ショップ"
        
        super.init(nibName: nil, bundle: nil)
        
        self.hidesBottomBarWhenPushed = true
    }
    
    override func loadView() {
        self.view = ShopDetailView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let view = self.view as! ShopDetailView
        
        self.navigationItem.title = titleName
        
        view.appendSubViews()
        
        Observable
            .combineLatest(model.shop, model.images)
            .asDriver(onErrorDriveWith: Driver.empty())
            .drive(onNext: { [weak self] (shop, images) in
                guard let `self` = self else { return }
                view.configure(shop: shop, shopImages: [UIImage](images.values))
                view.couponButton.addTarget(self, action: #selector(self.buttonTapped), for: .touchUpInside)
            })
            .disposed(by: disposeBag)
        
        
        self.view.backgroundColor = .white
    }
    
    @objc func buttonTapped() {
        //遷移処理 to be uncommented at couponlist branch
//        model.shop.drive(onNext: { [weak self] shop in
//            guard let `self` = self, let navigationController = self.navigationController else { return }
//            let couponListViewController = NewCouponListViewController(ofShop: shop)
//            navigationController.pushViewController(couponListViewController, animated: true)
//        })
//        .disposed(by: disposeBag)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
