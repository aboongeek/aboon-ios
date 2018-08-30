//
//  CouponListView.swift
//  aboon
//
//  Created by EXIST on 2018/07/29.
//  Copyright © 2018年 aboon. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class CouponListView: UIView {

    var couponListCollectionView: CouponListCollectionView!
    var refreshButton: UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: UIScreen.main.bounds)
        self.backgroundColor = UIColor(hex: "F5F5F5")
    }
    
    public func appendCollectionView () {
        self.addSubview(couponListCollectionView)
        
        couponListCollectionView.translatesAutoresizingMaskIntoConstraints = false
        
        if #available(iOS 11.0, *) {
            couponListCollectionView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor).isActive = true
            couponListCollectionView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor).isActive = true
            couponListCollectionView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor).isActive = true
            couponListCollectionView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor).isActive = true
        } else {
            couponListCollectionView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
            couponListCollectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
            couponListCollectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
            couponListCollectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        }
    }
    
    public func initializeCollectionView () -> CouponListCollectionView {
        couponListCollectionView = CouponListCollectionView(frame: frame, collectionViewLayout: UICollectionViewLayout())
        couponListCollectionView.translatesAutoresizingMaskIntoConstraints = false
        if #available(iOS 11.0, *) {
            couponListCollectionView.contentInset = safeAreaInsets
        } else {
            couponListCollectionView.contentSize = bounds.size
        }
        return couponListCollectionView
    }
    
    func appendRefreshButton() {
        refreshButton = UIButton(type: .system)
        refreshButton.setTitle("更新", for: .normal)
        refreshButton.frame = self.frame
        refreshButton.contentHorizontalAlignment = .center
        refreshButton.addTarget(self, action: #selector(notifyRefreshTapped), for: .touchDown)
        self.addSubview(refreshButton)
        refreshButton.translatesAutoresizingMaskIntoConstraints = false
        if #available(iOS 11.0, *) {
            refreshButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor).isActive = true
        } else {
            refreshButton.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        }
    }
    
    private let refreshTappedRelay = BehaviorRelay<Bool>(value: false)
    var refreshTapped: Observable<Bool> { return refreshTappedRelay.asObservable() }
    
    @objc func notifyRefreshTapped() {
        refreshTappedRelay.accept(true)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
