//
//  CouponRoomView.swift
//  aboon
//
//  Created by 原口和音 on 2018/08/12.
//  Copyright © 2018年 aboon. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class CouponRoomView: UIView {

    var couponListCollectionView: CouponListCollectionView!
    var couponRoomCollectionView: CouponRoomCollectionView!
    lazy var createCouponButton = UIButton()
    lazy var useCouponButton = UIButton()
    
    func appendCouponCollectionView() {
        couponListCollectionView = CouponListCollectionView(frame: frame, collectionViewLayout: UICollectionViewLayout())
        addSubview(couponListCollectionView)
    }
    
    func appendRoomCollectionView() {
        addSubview(couponRoomCollectionView)
    }
    
    func appendCreateCouponButton() {
        createCouponButton.setTitle("このクーポンを発行する", for: .normal)
        addSubview(createCouponButton)
        createCouponButton.addTarget(self, action: #selector(notifyCreateCouponPressed), for: .touchUpInside)
    }
    
    private let createCouponPressedRelay = BehaviorRelay<Bool>(value: false)
    var createCouponPressed: Observable<Bool> { return createCouponPressedRelay.asObservable()}
    
    
    @objc func notifyCreateCouponPressed() {
        createCouponPressedRelay.accept(true)
    }
    
    func appendUseCouponButton() {
        useCouponButton.setTitle("クーポンを使用する", for: .normal)
        addSubview(useCouponButton)
    }
    
    private let useCouponPressedRelay = BehaviorRelay<Bool>(value: false)
    var useCouponPressed: Observable<Bool> { return useCouponPressedRelay.asObservable()}
    
    @objc func notifyUseCouponPressed() {
        useCouponPressedRelay.accept(true)
    }
    
    
    func configure(isCreated: Bool, isOver: Bool) {
        appendCreateCouponButton()
        appendUseCouponButton()
        if !isCreated {
            createCouponButton.backgroundColor = UIColor(hex: "FF5C5C")
            createCouponButton.setTitleColor(.white, for: .normal)
        } else if isCreated && !isOver {
            createCouponButton.isHidden = true
            useCouponButton.backgroundColor = UIColor(hex: "000000", alpha: 0.1)
            useCouponButton.setTitleColor(UIColor(hex: "000000", alpha: 0.16), for: .disabled)
        } else if isOver {
            createCouponButton.isHidden = true
            useCouponButton.backgroundColor = UIColor(hex: "FF5C5C")
            useCouponButton.setTitleColor(.white, for: .normal)
            useCouponButton.addTarget(self, action: #selector(notifyUseCouponPressed), for: .touchUpInside)
        }
    }
}
