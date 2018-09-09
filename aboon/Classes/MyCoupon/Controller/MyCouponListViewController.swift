//
//  MyCouponListViewController.swift
//  aboon
//
//  Created by 原口和音 on 2018/06/24.
//  Copyright © 2018 aboon. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources

class MyCouponListViewController: UIViewController {
    
    let disposeBag = DisposeBag()
    
    lazy var couponListView = CouponListView()
    let model: MyCouponListCollectionModel
    lazy var dataSource = MyCouponListViewDataSource()
    
    //navname
    private let titleName = "マイクーポン"
    
    init() {
        model = MyCouponListCollectionModel()
        
        super.init(nibName: nil, bundle: nil)
    }
    
    override func loadView() {
        self.view = couponListView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.configureBarItems(title: titleName, navigationController: navigationController as! NavigationController)
        
        let myCouponlistCollectionView = couponListView.initializeCollectionView()
        couponListView.appendCollectionView()
        
        myCouponlistCollectionView.register(UINib(nibName: "MyCouponListCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "MyCouponListCollectionViewCell")
        
        Observable
            .combineLatest(model.coupons, model.images) {MyCouponListViewDataSource.Element(items: $0, images: $1)}
            .asDriver(onErrorDriveWith: Driver.empty())
            .drive(myCouponlistCollectionView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)

        dataSource
            .selectedCoupon
            .drive(onNext: { [weak self] (myCoupon, image) in
                guard let `self` = self,
                    let navigationController = self.navigationController
                    else { return }

                let couponRoomViewController = CouponRoomViewController(withRoomId: myCoupon.roomId, ofCoupon: (myCoupon, image))
                navigationController.pushViewController(couponRoomViewController, animated: true)
            })
            .disposed(by: disposeBag)
        
        myCouponlistCollectionView.delegate = dataSource
    }
    
    override func viewWillAppear(_ animated: Bool) {
        model.setUserListner()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        model.removeUserListner()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class MyCouponListViewDataSource: NSObject, UICollectionViewDataSource, RxCollectionViewDataSourceType, UICollectionViewDelegate {
    
    //RxCollectionViewDataSourceType
    struct Element {
        let items: [MyCoupon]
        let images: [String : UIImage]
    }
    
    var items = [MyCoupon]()
    var images = [String : UIImage]()
    
    func collectionView(_ collectionView: UICollectionView, observedEvent: Event<MyCouponListViewDataSource.Element>) {
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
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyCouponListCollectionViewCell", for: indexPath) as! MyCouponListCollectionViewCell
        if let image = images[items[indexPath.row].imagePath] {
            cell.configure(coupon: items[indexPath.row], image: image)
        } else {
            cell.configure(coupon: items[indexPath.row], image: UIImage())
        }
        return cell
    }
    
    //UICollectionViewDelegate
    private let selectedCouponSubject = PublishSubject<(MyCoupon, UIImage)>()
    var selectedCoupon: Driver<(MyCoupon, UIImage)> { return selectedCouponSubject.asDriver(onErrorDriveWith: Driver.empty()) }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let image = images[items[indexPath.row].imagePath] else { return }
        
        collectionView.deselectItem(at: indexPath, animated: true)
        selectedCouponSubject.onNext((items[indexPath.row], image))
    }
}
