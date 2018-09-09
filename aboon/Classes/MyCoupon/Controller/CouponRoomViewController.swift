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
import Firebase

class CouponRoomViewController: UIViewController {
    
    let disposeBag = DisposeBag()
    
    lazy var couponRoomView = CouponRoomView(frame: CGRect.zero)
    
    let model: CouponRoomModel
    lazy var dataSource = CouponRoomViewDataSource()
    
    var coupon: (coupon: Coupon, image: UIImage)?
    
    var isUserInvited: Bool
    
    var needsUserStateUpdate = false
    
    //navname
    private var titleName = "クーポン"
    
    init(ofCoupon coupon: (coupon: Coupon, image: UIImage)) {
        self.coupon = coupon
        self.model = CouponRoomModel(coupon: coupon.coupon)
        self.isUserInvited = false
        
        super.init(nibName: nil, bundle: nil)
    }
    
    init(withRoomId roomId: String, ofCoupon coupon: (coupon: Coupon, image: UIImage)) {
        self.coupon = coupon
        self.model = CouponRoomModel(withRoomId: roomId, coupon: coupon.coupon)
        self.isUserInvited = false
        
        super.init(nibName: nil, bundle: nil)
    }
    
    init(withJustRoomId roomId: String) {
        self.coupon = nil
        self.model = CouponRoomModel(withJustRoomId: roomId)
        self.isUserInvited = true
        
        super.init(nibName: nil, bundle: nil)
    }
    
    override func loadView() {
        self.view = couponRoomView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = titleName
        
        if let coupon = coupon {
            setup(coupon: coupon)
        } else {
            couponRoomView.appendActiviryIndicator()
            Observable
                .zip(model.couponObservable, model.couponImageObservable)
                .asDriver(onErrorDriveWith: Driver.empty())
                .drive (
                    onNext: {[weak self] (coupon, image) in
                        guard let `self` = self else { return }
                        self.coupon = (coupon, image)
                        self.setup(coupon: self.coupon!)
                    })
                .disposed(by: disposeBag)
        }
       
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.model.setUserListner()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.model.removeUserListner()
    }
    
    func setup(coupon: (coupon : Coupon, image : UIImage)) {
        couponRoomView.couponRoomCollectionView.register(UINib(nibName: "CouponRoomCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CouponRoomCollectionViewCell")
        couponRoomView.couponRoomCollectionView.delegate = dataSource
        
        if isUserInvited {
            
            couponRoomView.removeActivityIndicator()
            
            couponRoomView
                .declinePressed
                .asDriver(onErrorDriveWith: Driver.empty())
                .drive(onNext: { [weak self] isPressed in
                    guard let `self` = self, let navigationController = self.navigationController else { return }
                    if isPressed {
                        navigationController.popViewController(animated: true)
                    }
                })
                .disposed(by: disposeBag)
            
            couponRoomView
                .aceptPressed
                .asDriver(onErrorDriveWith: Driver.empty())
                .drive(onNext: { [weak self] isPressed in
                    guard let `self` = self else { return }
                    if isPressed {
                        if let user = self.model.user {
                            self.isUserInvited = false
                            self.model.addMember(member: Member(userName: user.displayName!, userId: user.uid), isOwner: false)
                        } else {
                            let signInViewController = SignInViewController()
                            self.present(signInViewController, animated: true, completion: nil)
                        }
                    }
                })
                .disposed(by: disposeBag)
        }
        
        model
            .minimumCheck
            .subscribe(onNext:  { [weak self] (isOver, numberOfItems) in
                guard let `self` = self else { return }
                self.couponRoomView.configure(coupon: coupon.coupon,
                                              image: coupon.image,
                                              numberOfItems: numberOfItems,
                                              isRoomCreated: (self.model.roomId != nil),
                                              isOver: isOver,
                                              isInvited: self.isUserInvited)
            })
            .disposed(by: disposeBag)
        
        model
            .members
            .asDriver(onErrorDriveWith: Driver.empty())
            .drive(couponRoomView.couponRoomCollectionView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
        
        couponRoomView
            .createCouponPressed
            .asDriver(onErrorDriveWith: Driver.empty())
            .drive(onNext: { [weak self] (isPressed) in
                guard let `self` = self else { return }
                
                if isPressed {
                    if let user = self.model.user {
                        if let userName = user.displayName {
                            let member = Member(userName: userName, userId: user.uid)
                            self.model.createRoom(by: member)
                            self.model.generateShareItems()
                        }
                    } else {
                        let signInViewController = SignInViewController()
                        self.present(signInViewController, animated: true, completion: nil)
                    }
                }
            })
            .disposed(by: disposeBag)
        
        Observable
            .combineLatest(couponRoomView.invitePressed, model.itemsToBeShared)
            .asDriver(onErrorDriveWith: Driver.empty())
            .drive(onNext: { [weak self] isPressed, items in
                guard let `self` = self else { return }
                if isPressed {
                    let activityController = UIActivityViewController(activityItems: items, applicationActivities: nil)
                    self.present(activityController, animated: true, completion: nil)
                }
            })
            .disposed(by: disposeBag)
        
        couponRoomView
            .useCouponPressed
            .asDriver(onErrorDriveWith: Driver.empty())
            .drive(onNext: { [weak self] (isPressed) in
                guard let `self` = self else { return }
                if isPressed {
                    guard let roomId = self.model.roomId else { return }
                    let couponConfirmationViewController = CouponConfirmationViewController(coupon: coupon.coupon, roomId: roomId, image: coupon.image)
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

class CouponRoomViewDataSource: NSObject, UICollectionViewDataSource, RxCollectionViewDataSourceType, UICollectionViewDelegateFlowLayout {
    
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
        return items.count
    }
        
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CouponRoomCollectionViewCell", for: indexPath) as! CouponRoomCollectionViewCell
        let userName = items[indexPath.row].userName
        cell.configure(userName: userName)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemWidth = collectionView.frame.width - 40
        let itemSize = CGSize(width: itemWidth, height: 56)
        return itemSize
    }
}
