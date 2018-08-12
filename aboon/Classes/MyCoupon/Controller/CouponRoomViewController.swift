//
//  CouponRoomViewController.swift
//  aboon
//
//  Created by 原口和音 on 2018/08/12.
//  Copyright © 2018年 aboon. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources

class CouponRoomViewController: UIViewController {
    
    let disposeBag = DisposeBag()
    
    lazy var couponRoomView = CouponRoomView()
    
    let model: CouponRoomModel
    lazy var dataSource = CouponRoomViewDataSource()
    
    let coupon: (coupon: Coupon, image: UIImage)
    
    //navname
    private var titleName = "クーポン"
    
    init(ofCoupon coupon: (coupon: Coupon, image: UIImage)) {
        
        self.coupon = coupon
        
        model = CouponRoomModel(coupon: coupon.coupon)
        
        super.init(nibName: nil, bundle: nil)
    }
    
    init(withRoomId roomId: String, ofCoupon coupon: (coupon: Coupon, image: UIImage)) {
        
        self.coupon = coupon
        
        model = CouponRoomModel(withRoomId: roomId, coupon: coupon.coupon)
        
        super.init(nibName: nil, bundle: nil)
    }
    
    override func loadView() {
        self.view = couponRoomView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = titleName
        
        couponRoomView.appendCouponCollectionView()
        couponRoomView.appendRoomCollectionView()
        
        couponRoomView.couponListCollectionView.register(CouponListCollectionViewCell.self, forCellWithReuseIdentifier: "CouponListCollectionViewCell")
        couponRoomView.couponListCollectionView.dataSource = self
        
        couponRoomView.couponRoomCollectionView.register(CouponRoomCollectionViewCell.self, forCellWithReuseIdentifier: "CouponRoomCollectionViewCell")
        couponRoomView.couponRoomCollectionView.delegate = dataSource
        
        couponRoomView
            .createCouponPressed
            .subscribe(onNext: { [weak self] (isPressed) in
                guard let `self` = self else { return }
                
                if isPressed {
                    if let user = self.model.user {
                        if let userName = user.displayName {
                            let member = Member(userName: userName, userId: user.uid)
                            self.model.createRoom(by: member)
                        }
                    } else {
                        let signInViewController = SignInViewController()
                        self.present(signInViewController, animated: true, completion: nil)
                    }
                }
            })
            .disposed(by: disposeBag)
        
        model
            .members
            .asDriver(onErrorDriveWith: Driver.empty())
            .drive(couponRoomView.couponRoomCollectionView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
        
        model
            .minimumCheck
            .subscribe(onNext:  { [weak self] (isOver) in
                guard let `self` = self else { return }
                self.couponRoomView.configure(isCreated: (self.model.roomId != nil), isOver: isOver)
            })
            .disposed(by: disposeBag)
        
        dataSource
            .invitePressed
            .subscribe(onNext: { [weak self] (isPressed) in
                guard let `self` = self else { return }
                if isPressed {
                    let invitationURL = ""
                    let activityController = UIActivityViewController(activityItems: [invitationURL], applicationActivities: nil)
                    self.present(activityController, animated: true, completion: nil)
                }
            })
            .disposed(by: disposeBag)

        couponRoomView
            .useCouponPressed
            .subscribe(onNext: { [weak self] (isPressed) in
                guard let `self` = self else { return }
                if isPressed {
                    let couponConfirmationViewController = CouponConfirmationViewController(coupon: self.coupon.coupon, image: self.coupon.image)
                    self.present(couponConfirmationViewController, animated: true, completion: nil)
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

extension CouponRoomViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = CouponListCollectionViewCell()
        cell.configure(name: coupon.coupon.name, description: coupon.coupon.description, image: coupon.image)
        return cell
    }
}


class CouponRoomViewDataSource: NSObject, UICollectionViewDataSource, RxCollectionViewDataSourceType, UICollectionViewDelegate {
    
    //RxCollectionViewDataSourceType
    typealias Element = [Member]
    var items = Element()
    
    func collectionView(_ collectionView: UICollectionView, observedEvent: Event<CouponRoomViewDataSource.Element>) {
        if case .next(let items) = observedEvent {
            self.items = items
            collectionView.reloadData()
        }
    }
    
    //UICollectionViewDataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count + 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if (indexPath.row != items.count) {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CouponRoomCollectionViewCell", for: indexPath) as! CouponRoomCollectionViewCell
            let userName = items[indexPath.row].userName
            cell.nameLabel.text = userName
            return cell
        } else {
            let cell = CouponRoomInviteViewCell()
            return cell
        }
        
    }
    
    //UICollectionViewDelegate
    private let invitePressedSubject = PublishSubject<Bool>()
    var invitePressed: Observable<Bool> { return invitePressedSubject.asObservable() }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if (indexPath.row == items.count - 1) {
            invitePressedSubject.onNext(true)
        }
    }
    
}
