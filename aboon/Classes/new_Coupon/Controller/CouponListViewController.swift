//
//  CouponListViewController.swift
//  aboon
//
//  Created by EXIST on 2018/07/29.
//  Copyright © 2018年 aboon. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources

class CouponListViewController: UIViewController {
    
    let disposeBag = DisposeBag()
    
    lazy var couponListView = CouponListView()
    let model: CouponListCollectionModel
    lazy var dataSource = CouponListViewDataSource()
    
    //navname
    private let titleName = "クーポン"
    
    init(shopId: Int) {
        model = CouponListCollectionModel(shopId: shopId)
        
        super.init(nibName: nil, bundle: nil)
        
        self.hidesBottomBarWhenPushed = true
    }
    
    override func loadView() {
        self.view = couponListView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = titleName
        
        let couponlistCollectionView = couponListView.initializeCollectionView()
        couponListView.appendCollectionView()
        
        couponlistCollectionView.register(UINib(nibName: "CouponListCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CouponListCollectionViewCell")
        
        Observable
            .combineLatest(model.coupons, model.images) {CouponListViewDataSource.Element(items: $0, images: $1)}
            .asDriver(onErrorDriveWith: Driver.empty())
            .drive(couponlistCollectionView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
        
        dataSource
            .selectedCoupon
            .drive(onNext: { [weak self] (coupon, image) in
                guard let `self` = self,
                    let navigationController = self.navigationController else { return }
                
                let couponRoomViewController = CouponRoomViewController(ofCoupon: (coupon, image))
                navigationController.pushViewController(couponRoomViewController, animated: true)
            })
            .disposed(by: disposeBag)
        
        couponlistCollectionView.delegate = dataSource
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

class CouponListViewDataSource: NSObject, UICollectionViewDataSource, RxCollectionViewDataSourceType, UICollectionViewDelegate {    
    
    //RxCollectionViewDataSourceType
    struct Element {
        let items: [Coupon]
        let images: [String : UIImage]
    }
    
    var items = [Coupon]()
    var images = [String : UIImage]()
    
    func collectionView(_ collectionView: UICollectionView, observedEvent: Event<CouponListViewDataSource.Element>) {
        if case .next(let element) = observedEvent {
            items = element.items
            images = element.images
            collectionView.reloadData()
        }
    }
    
    //UICollectionViewDataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CouponListCollectionViewCell", for: indexPath) as! CouponListCollectionViewCell
        if let image = images[items[indexPath.row].imagePath] {
            cell.configure(coupon: items[indexPath.row], image: image)
        } else {
            cell.configure(coupon: items[indexPath.row], image: UIImage())
        }
        return cell
    }
    
    //UICollectionViewDelegate
    private let selectedCouponSubject = PublishSubject<(Coupon, UIImage)>()
    var selectedCoupon: Driver<(Coupon, UIImage)> { return selectedCouponSubject.asDriver(onErrorDriveWith: Driver.empty()) }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let image = images[items[indexPath.row].imagePath] else { return }
        
        collectionView.deselectItem(at: indexPath, animated: true)
        selectedCouponSubject.onNext((items[indexPath.row], image))
    }
}
