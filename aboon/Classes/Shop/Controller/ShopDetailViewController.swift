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
    
    lazy var shopDetailView = ShopDetailView(frame: CGRect.zero)
    let model: ShopDetailModel
    
    let shopId: Int
    
    private let titleName: String
    
    init(ofShop shop: ShopSummary) {
        self.model = ShopDetailModel(shopRef: shop.documentRef, storageRef: shop.storageRef)
        self.titleName = "ショップ"
        self.shopId = shop.id
        
        super.init(nibName: nil, bundle: nil)
        
        self.hidesBottomBarWhenPushed = true
    }
    
    override func loadView() {
        self.view = shopDetailView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let view = self.view as! ShopDetailView
        
        self.navigationItem.title = titleName
        
        view.scrollView.delegate = self
        
        model
            .shop
            .asDriver(onErrorDriveWith: Driver.empty())
            .drive(onNext: {[weak self] shop in
                guard let `self` = self else { return }
                view.configure(shop: shop)
                view.couponButton.addTarget(self, action: #selector(self.buttonTapped), for: .touchUpInside)
            })
            .disposed(by: disposeBag)
        
        model
            .images
            .asDriver(onErrorDriveWith: Driver.empty())
            .drive(onNext: { imageWithIndex in
                view.scrollView.addImage(imageWithIndex)
            })
            .disposed(by: disposeBag)
        
        view
            .descriptionView
            .urlObservable
            .subscribe(onNext: { [weak self] (url) in
                guard let `self` = self else { return }
                let webViewController = WebViewController(url: url)
                self.present(webViewController, animated: true, completion: nil)
            })
            .disposed(by: disposeBag)
        
    }
    
    @objc func buttonTapped() {
       
        guard let navigationController = self.navigationController else { return }
        let couponListViewController = CouponListViewController(shopId: shopId)
        navigationController.pushViewController(couponListViewController, animated: true)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension ShopDetailViewController: UIScrollViewDelegate {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let currentPage = lround(Double(shopDetailView.scrollView.contentOffset.x / scrollView.frame.width))
        shopDetailView.pageControl.currentPage = currentPage
    }
}
