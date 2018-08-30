//
//  ShopDetailDescriptionView.swift
//  aboon
//
//  Created by 原口和音 on 2018/08/02.
//  Copyright © 2018年 aboon. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ShopDetailDescriptionView: UIView {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var shopInfoLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var businessHoursLabel: UILabel!
    @IBOutlet weak var webURLButton: UIButton!
    @IBOutlet weak var fbURLButton: UIButton!
    @IBOutlet weak var instaURLButton: UIButton!
    @IBOutlet weak var emailTextView: UITextView!
    @IBOutlet weak var phoneTextView: UITextView!
    @IBOutlet weak var descriptionView: UITextView!

    var url: URL?
    
    private let urlSubject = PublishSubject<URL>()
    var urlObservable: Observable<URL> { return urlSubject.asObservable()}
    
    @objc func urlTapped() {
        if let url = self.url {
            urlSubject.onNext(url)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadNib()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        loadNib()
    }
    
    private func loadNib() {
        guard let view = UINib(nibName: "ShopDetailDescriptionView", bundle: nil).instantiate(withOwner: self, options: nil).first as? UIView else {
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
    
    func configure(shop: Shop) {
        nameLabel.text = shop.name
        addressLabel.text = shop.address
        businessHoursLabel.text = shop.businessHours
        
        if let url = shop.webURL {
            self.url = URL(string: url)
            webURLButton.addTarget(self, action: #selector(urlTapped), for: .touchUpInside)
        } else {
            webURLButton.isHidden = true
        }
        
        if let url = shop.fbURL {
            self.url = URL(string: url)
            fbURLButton.addTarget(self, action: #selector(urlTapped), for: .touchUpInside)
        } else {
            fbURLButton.isHidden = true
        }
        
        if let url = shop.instaURL {
            self.url = URL(string: url)
            instaURLButton.addTarget(self, action: #selector(urlTapped), for: .touchUpInside)
        } else {
            instaURLButton.isHidden = true
        }
        
        emailTextView.text = shop.email
        phoneTextView.text = shop.phone
        descriptionView.text = shop.description
    }

}
