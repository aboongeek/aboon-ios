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
    
    @IBOutlet weak var couponRoomCollectionView: UICollectionView!
    @IBOutlet weak var collectionLayout: UICollectionViewFlowLayout!
    @IBOutlet weak var couponToInviteConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var couponView: UIView!
    @IBOutlet weak var couponImageView: UIImageView!
    @IBOutlet weak var couponNameLabel: UILabel!
    @IBOutlet weak var couponDescriptionLabel: UILabel!
    @IBOutlet weak var inviteButton: UIButton!
    @IBOutlet weak var issueButton: UIButton!
    @IBOutlet weak var declineButton: UIButton!
    @IBOutlet weak var acceptButton: UIButton!
    
    private var view: UIView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadNib()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        loadNib()
    }
    
    private func loadNib() {
        guard let view = UINib(nibName: "CouponRoomView", bundle: nil).instantiate(withOwner: self, options: nil).first as? UIView else {
            return
        }
        self.view = view
        addSubview(view)
        
        view.translatesAutoresizingMaskIntoConstraints = false
        view.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        view.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        view.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        view.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        
    }
    
    func configure(coupon: Coupon, image: UIImage, numberOfItems: Int, isRoomCreated: Bool, isOver: Bool, isInvited: Bool) {
        configureCoupon(coupon: coupon, image: image)
        configureCollection(isRoomCreated: isRoomCreated, numberOfItems: numberOfItems)
        configureButtons(isCreated: isRoomCreated, isOver: isOver, isInvited: isInvited)
    }
    
    private func configureCoupon(coupon: Coupon, image: UIImage) {
        couponImageView.image = image
        couponNameLabel.text = coupon.name
        couponDescriptionLabel.text = coupon.description
        addShadow(view: couponView)
    }
    
    private func configureCollection(isRoomCreated: Bool, numberOfItems: Int) {
        if isRoomCreated {
            let height = (collectionLayout.itemSize.height + collectionLayout.minimumLineSpacing)  * CGFloat(numberOfItems) + collectionLayout.sectionInset.top
            couponToInviteConstraint.constant = height
        }
    }
    
    private let invitePressedRelay = BehaviorRelay<Bool>(value: false)
    var invitePressed: Observable<Bool> { return invitePressedRelay.asObservable()}
    
    @IBAction func notifyInvitePressed(_ sender: Any) {
        invitePressedRelay.accept(true)
    }
    
    private let createCouponPressedRelay = BehaviorRelay<Bool>(value: false)
    var createCouponPressed: Observable<Bool> { return createCouponPressedRelay.asObservable()}
    
    @objc func notifyCreateCouponPressed() {
        createCouponPressedRelay.accept(true)
    }
    
    private let useCouponPressedRelay = BehaviorRelay<Bool>(value: false)
    var useCouponPressed: Observable<Bool> { return useCouponPressedRelay.asObservable()}
    
    @objc func notifyUseCouponPressed() {
        useCouponPressedRelay.accept(true)
    }
    
    private let declinePressedRelay = BehaviorRelay<Bool>(value: false)
    var declinePressed: Observable<Bool> { return declinePressedRelay.asObservable()}
    
    @IBAction func notifyDeclinePressed(_ sender: Any) {
        declinePressedRelay.accept(true)
    }
    
    private let acceptPressedRelay = BehaviorRelay<Bool>(value: false)
    var aceptPressed: Observable<Bool> { return acceptPressedRelay.asObservable()}
    
    @IBAction func notifyAcceptPressed(_ sender: Any) {
        acceptPressedRelay.accept(true)
    }
    
    
    private func configureButtons(isCreated: Bool, isOver: Bool, isInvited: Bool) {
        setRoundEdgeAndShadow(views: [issueButton, inviteButton, declineButton, acceptButton], cornderRadius: 16)
        
        if !isCreated {
            inviteButton.isEnabled = false
            inviteButton.backgroundColor = UIColor(hex: "000000", alpha: 0.1)
            inviteButton.setTitleColor(UIColor(hex: "000000", alpha: 0.16), for: .disabled)
            
            issueButton.isEnabled = true
            issueButton.backgroundColor = UIColor(hex: "FF5C5C")
            issueButton.setTitle("クーポンを発行する", for: .normal)
            issueButton.setTitleColor(.white, for: .normal)
            issueButton.addTarget(self, action: #selector(notifyCreateCouponPressed), for: .touchUpInside)
            
            declineButton.isHidden = true
            acceptButton.isHidden = true
        } else {
            if !isInvited {
                if !isOver {
                    inviteButton.isEnabled = true
                    inviteButton.backgroundColor = UIColor(hex: "FF5C5C")
                    inviteButton.setTitleColor(.white, for: .normal)
                    
                    issueButton.isEnabled = false
                    issueButton.backgroundColor = UIColor(hex: "000000", alpha: 0.1)
                    issueButton.setTitle("クーポンを使用する", for: .disabled)
                    issueButton.setTitleColor(UIColor(hex: "000000", alpha: 0.16), for: .disabled)
                    
                    declineButton.isHidden = true
                    acceptButton.isHidden = true
                } else {
                    inviteButton.isEnabled = true
                    inviteButton.backgroundColor = UIColor(hex: "FF5C5C")
                    inviteButton.setTitleColor(.white, for: .normal)
                    
                    issueButton.isEnabled = true
                    issueButton.backgroundColor = UIColor(hex: "FF5C5C")
                    issueButton.setTitle("クーポンを使用する", for: .normal)
                    issueButton.removeTarget(self, action: #selector(notifyCreateCouponPressed), for: .touchUpInside)
                    issueButton.addTarget(self, action: #selector(notifyUseCouponPressed), for: .touchUpInside)
                    
                    declineButton.isHidden = true
                    acceptButton.isHidden = true
                }
            } else {
                declineButton.isHidden = false
                acceptButton.isHidden = false
                
                inviteButton.isEnabled = true
                inviteButton.backgroundColor = UIColor(hex: "FF5C5C")
                inviteButton.setTitleColor(.white, for: .normal)
                
                issueButton.isHidden = true
            }
        }
    }
    
    func setRoundEdgeAndShadow(views: [UIView], cornderRadius: CGFloat) {
        views.forEach { (view) in
            roundEdge(view: view, constant: cornderRadius)
            addShadow(view: view)
        }
    }
    
    func roundEdge(view: UIView, constant: CGFloat) {
        view.layer.cornerRadius = constant
        view.clipsToBounds = true
    }
    
    func addShadow(view: UIView) {
        view.layer.masksToBounds = false
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.16
        view.layer.shadowOffset = CGSize(width: 0, height: 3)
        view.layer.shadowRadius = 5
    }
}
