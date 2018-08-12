//
//  CouponConfirmationView.swift
//  aboon
//
//  Created by 原口和音 on 2018/08/12.
//  Copyright © 2018年 aboon. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class CouponConfirmationView: UIView {

    let couponView = UIView()
    let couponImageView = UIImageView()
    let couponNameLabel = UILabel()
    let couponDescriptionLabel = UILabel()
    let couponExpirationLabel = UILabel()
    let aboonLabel = UILabel()
    let useCouponButton = UIButton()
    let dismissButton = UIButton()
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
    }
    
    func configure(coupon: Coupon, image: UIImage) {
        couponImageView.image = image
        couponNameLabel.text = coupon.name
        couponDescriptionLabel.text = coupon.description
        aboonLabel.text = "aboon"
        
        useCouponButton.setTitle("クーポンを使用する", for: .normal)
        useCouponButton.addTarget(self, action: #selector(notifyUseCouponPressed), for: .touchUpInside)
        
        dismissButton.setImage(R.image.circleX7(), for: .normal)
        dismissButton.addTarget(self, action: #selector(notifyDismissPressed), for: .touchDown)
        
    }
    
    private let useCouponPressedRelay = BehaviorRelay<Bool>(value: false)
    var useCouponPressed: Observable<Bool> { return useCouponPressedRelay.asObservable() }
    
    @objc func notifyUseCouponPressed() {
        useCouponPressedRelay.accept(true)
    }
    
    private let dismissPressedRelay = BehaviorRelay<Bool>(value: false)
    var dismissPressed: Observable<Bool> { return dismissPressedRelay.asObservable()}
    
    @objc func notifyDismissPressed() {
        dismissPressedRelay.accept(true)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
