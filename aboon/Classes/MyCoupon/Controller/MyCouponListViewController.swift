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
    
    let model: MyCouponListCollectionModel
    lazy var dataSource = MyCouponListViewDataSource()
    
    //navname
    private var titleName = "マイクーポン"
    
    init() {
        model = MyCouponListCollectionModel()
        
        super.init(nibName: nil, bundle: nil)
    }
    
    override func loadView() {
        self.view = CouponListView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let myCouponListView = self.view as! CouponListView
        
        self.navigationItem.title = titleName
        
        let myCouponlistCollectionView = myCouponListView.initializeCollectionView()
        myCouponListView.appendCollectionView()
        
        myCouponlistCollectionView.register(MyCouponListCollectionViewCell.self, forCellWithReuseIdentifier: "MyCouponListCollectionViewCell")
        
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
                //遷移処理
                let couponRoomViewController = CouponRoomViewController(withRoomId: myCoupon.roomId, ofCoupon: (myCoupon, image))
                navigationController.pushViewController(couponRoomViewController, animated: true)
            })
            .disposed(by: disposeBag)
        
        myCouponlistCollectionView.delegate = dataSource
    }
    
    override func viewWillAppear(_ animated: Bool) {
        model
            .isUserNotSignedIn
            .subscribe(onNext: { [weak self] (isUserNotSignedIn) in
                guard let `self` = self else { return }
                if isUserNotSignedIn {
                    self.present(SignInViewController(), animated: true, completion: nil)
                }
            })
            .disposed(by: disposeBag)
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
        let name = items[indexPath.row].name
        let description = items[indexPath.row].description
        let isAvailable = items[indexPath.row].isAvailable
        if let image = images[items[indexPath.row].imagePath] {
            cell.configure(name: name, description: description, image: image, isAvailable: isAvailable)
        } else {
            cell.configure(name: name, description: description, image: UIImage(), isAvailable: isAvailable)
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
