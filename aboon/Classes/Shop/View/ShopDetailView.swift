//
//  ShopDetailView.swift
//  aboon
//
//  Created by 原口和音 on 2018/08/02.
//  Copyright © 2018年 aboon. All rights reserved.
//

import UIKit
import RxSwift

class ShopDetailView: UIView {

    var scrollView: ShopDetailScrollView!
    var pageControl: UIPageControl!
    var descriptionView: ShopDetailDescriptionView!
    var couponButton: UIButton!
    
    func appendSubViews() {
        appendScrollView()
        appendPageControl()
        appendCouponButton()
        appendDescriptionView()
    }
    
    private func appendScrollView() {
        scrollView = ShopDetailScrollView(frame: frame, numberOfPages: 1)
        addSubview(scrollView)
    }
    
    private func appendPageControl() {
        pageControl = UIPageControl()
        pageControl.numberOfPages = 1
        pageControl.pageIndicatorTintColor = .white
        pageControl.currentPageIndicatorTintColor = .gray
        addSubview(pageControl)
    }
    
    private func appendDescriptionView() {
        descriptionView = ShopDetailDescriptionView(frame: frame)
        addSubview(descriptionView)
    }
    
    private func appendCouponButton() {
        couponButton = UIButton(type: .custom)
        addSubview(couponButton)
    }
    
    func configure(shop: Shop) {
        scrollView.numberOfPages = shop.imagePaths.count
        pageControl.numberOfPages = shop.imagePaths.count
        
        descriptionView.addressLabel.text = shop.address
        descriptionView.businessHoursLabel.text = shop.businessHours
        descriptionView.descriptionView.text = shop.description
        descriptionView.nameLabel.text = shop.name
        descriptionView.emailLabel.text = shop.email
        descriptionView.phoneLabel.text = shop.phone
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
   
    
}
