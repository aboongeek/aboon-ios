//
//  ShopListCollectionBanner.swift
//  aboon
//
//  Created by 原口和音 on 2018/08/16.
//  Copyright © 2018年 aboon. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ShopListCollectionBanner: UIView {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
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
        guard let view = UINib(nibName: "ShopListCollectionBanner", bundle: nil).instantiate(withOwner: self, options: nil).first as? UIView else {
            return
        }
        addSubview(view)
        
        view.translatesAutoresizingMaskIntoConstraints = false
        view.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        view.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        view.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        view.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
    }
    
    var imageViews = [String : UIImageView]()
    var featureds = [Featured]()
    
    func configure(featured: [Featured]) {
        setUpPages(featureds: featured)
        pageControl.isHidden = false
        pageControl.numberOfPages = featured.count
    }
    
    func setUpPages(featureds: [Featured]) {
        let numberOfPages = featureds.count

        for currentPage in 0..<numberOfPages {
            let position = CGPoint(x: CGFloat(currentPage) * frame.width, y: 0)
            let imageView = UIImageView(frame: CGRect(origin: position, size: frame.size))
            
            let imagePath = featureds[currentPage].imagePath
            
            imageView.tag = currentPage
            
            imageView.isUserInteractionEnabled = true
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(notifyItemSelected(_:)))
            imageView.addGestureRecognizer(tapGesture)
            imageViews[imagePath] = imageView
            self.featureds.append(featureds[currentPage])
            
            scrollView.addSubview(imageView)
        }
        
        scrollView.contentSize = CGSize(width: frame.width * CGFloat(numberOfPages), height: frame.height)
        scrollView.bounces = true
        scrollView.isPagingEnabled = true
        scrollView.showsHorizontalScrollIndicator = false
    }
    
    private let selectedItemSubject = PublishSubject<Featured>()
    var selectedItem: Observable<Featured> { return selectedItemSubject.asObservable() }
    
    @objc func notifyItemSelected(_ sender: UITapGestureRecognizer) {
        if let imageView = sender.view {
            selectedItemSubject.onNext(featureds[imageView.tag])
        }
    }
    
    func addImages(_ imagesWithPaths: [String : UIImage]) {
        imagesWithPaths.forEach { imageWithPath in
            if let imageView = imageViews[imageWithPath.key] {
                imageView.image = imageWithPath.value
            }
        }
    }
    
    
}
