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

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var couponButton: UIButton!
    @IBOutlet weak var dismissButton: UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadNib()
        self.backgroundColor = .clear
        self.isOpaque = false
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        loadNib()
    }
    
    private func loadNib() {
        guard let view = UINib(nibName: "CouponConfirmationView", bundle: nil).instantiate(withOwner: self, options: nil).first as? UIView else {
            return
        }
        addSubview(view)
        
        // カスタムViewのサイズを自分自身と同じサイズにする
        view.translatesAutoresizingMaskIntoConstraints = false
        view.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        view.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        view.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        view.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
    }

    
    func configure(coupon: Coupon, image: UIImage) {
        imageView.image = image
        nameLabel.text = coupon.name
        descriptionLabel.text = coupon.description
    }
    
    private let couponConfirmedRelay = BehaviorRelay<Bool>(value: false)
    var couponConfirmed: Observable<Bool> { return couponConfirmedRelay.asObservable() }
    
    @IBAction func notifyCouponConfirmed() {
        couponConfirmedRelay.accept(true)
    }
    
    private let dismissPressedRelay = BehaviorRelay<Bool>(value: false)
    var dismissPressed: Observable<Bool> { return dismissPressedRelay.asObservable()}
    
    @IBAction func notifyDismissPressed() {
        dismissPressedRelay.accept(true)
    }
    
    
    
}
