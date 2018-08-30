//
//  CouponRoomInviteViewCell.swift
//  aboon
//
//  Created by 原口和音 on 2018/08/12.
//  Copyright © 2018年 aboon. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class CouponRoomInviteViewCell: UICollectionViewCell {
    
    let inviteButton = UIButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .lightGray
        
        self.layer.cornerRadius = 16
        self.clipsToBounds = true
        
        inviteButton.isEnabled = false
        
        inviteButton.backgroundColor = UIColor(hex: "000000", alpha: 0.1)
        
        inviteButton.setTitle("友達を誘う", for: .disabled)
        inviteButton.setTitleColor(.darkGray, for: .disabled)
        
        inviteButton.setTitle("友達を誘う", for: .normal)
        inviteButton.setTitleColor(.white, for: .normal)
        
        inviteButton.addTarget(self, action: #selector(notifyInvitePressed), for: .touchUpInside)

        
        addSubview(inviteButton)
        inviteButton.translatesAutoresizingMaskIntoConstraints = false
        inviteButton.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        inviteButton.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        inviteButton.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        inviteButton.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        
    }
    
    private let invitePressedRelay = BehaviorRelay<Bool>(value: false)
    var invitePressed: Observable<Bool> { return invitePressedRelay.asObservable() }
    
    func configure(isCreated: Bool) {
        if !isCreated {
            inviteButton.isEnabled = false
            
        } else {
            inviteButton.backgroundColor = UIColor(hex: "FF5C5C")
            inviteButton.isEnabled = true
        }
    }
    
    @objc func notifyInvitePressed() {
        invitePressedRelay.accept(true)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
