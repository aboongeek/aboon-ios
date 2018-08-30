//
//  ShopDetailView.swift
//  aboon
//
//  Created by 原口和音 on 2018/08/02.
//  Copyright © 2018年 aboon. All rights reserved.
//

import UIKit

class ShopDetailView: UIView {
    
  
    @IBOutlet weak var scrollView: ShopDetailScrollView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var descriptionView: ShopDetailDescriptionView!
    @IBOutlet weak var descriptionExpansionButton: UIButton!
    @IBOutlet weak var couponButton: UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.loadNib()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.loadNib()
    }
    
    private func loadNib() {
        guard let view = UINib(nibName: "ShopDetailView", bundle: nil).instantiate(withOwner: self, options: nil).first as? UIView else {
            return
        }
        addSubview(view)
        
        view.translatesAutoresizingMaskIntoConstraints = false
        view.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        view.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        view.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        view.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true

        roundEdge(view: descriptionView, constant: 16)
        roundEdge(view: descriptionExpansionButton, constant: 4)
        roundEdge(view: couponButton, constant: 16)
    }

    var isExpanded = false
   
    
    @IBOutlet weak var descriptionViewTopConstraint: NSLayoutConstraint!
    
    @IBAction func expansionTapped(_ sender: Any) {
        toggleExpansion()
    }
    
    @IBOutlet var swipeGesture: UISwipeGestureRecognizer!

    @IBAction func descriptionViewSwiped(_ sender: UISwipeGestureRecognizer) {
        toggleExpansion()
    }
    
    func toggleExpansion() {
        isExpanded = !isExpanded
        if isExpanded {
            descriptionView.layoutIfNeeded()
            
            descriptionView.descriptionView.isHidden = false
            
            descriptionViewTopConstraint.constant = -240
            
            UIView.animate(withDuration: 0.2) {
                self.descriptionView.layoutIfNeeded()
            }
            
            swipeGesture.direction = .down
        } else {
            descriptionView.layoutIfNeeded()
            
            descriptionView.descriptionView.isHidden = true
            
            descriptionViewTopConstraint.constant = -10
            
            UIView.animate(withDuration: 0.2) {
                self.descriptionView.layoutIfNeeded()
            }
            
            swipeGesture.direction = .up
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        descriptionView.descriptionView.isHidden = true
    }
    
    func configure(shop: Shop) {
        scrollView.setUpPages(numberOfPages: shop.imagePaths.count)
        
        pageControl.numberOfPages = shop.imagePaths.count
        
        descriptionView.configure(shop: shop)
        
        addShadow()
    }
    
    func roundEdge(view: UIView, constant: CGFloat) {
        view.layer.cornerRadius = constant
        view.clipsToBounds = true
    }
    
    func addShadow() {
        couponButton.layer.masksToBounds = false
        couponButton.layer.shadowColor = UIColor.black.cgColor
        couponButton.layer.shadowOpacity = 0.16
        couponButton.layer.shadowOffset = CGSize(width: 0, height: 3)
        couponButton.layer.shadowRadius = 5
    }
}
