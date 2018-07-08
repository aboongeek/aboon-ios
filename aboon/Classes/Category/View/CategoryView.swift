//
//  CategoryView.swift
//  aboon
//
//  Created by 原口 和音 on 2018/06/27.
//  Copyright © 2018年 aboon. All rights reserved.
//

import UIKit

class CategoryView: UIView {
    
    var categoryCollectionView: CategoryCollectionView!
    var activityIndicator: UIActivityIndicatorView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
    }
    
    public func setFrame (tabBar: UITabBar, navBar: NavigationBar) {
        let frameHeight = UIScreen.main.bounds.size.height - tabBar.frame.size.height - navBar.frame.size.height - UIApplication.shared.statusBarFrame.height
        let frameSize = CGSize(width: UIScreen.main.bounds.size.width, height: frameHeight)
        self.frame = CGRect(origin: frame.origin, size: frameSize)
    }
    
    public func appendActivityIndicator () {
        activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.gray)
        activityIndicator.center = center
        addSubview(activityIndicator)
        activityIndicator.startAnimating()
    }
    
    public func stopActivityIndicator () {
        activityIndicator.stopAnimating()
    }
    
    public func initializeCollectionView(numberOfCells: Int) -> CategoryCollectionView {
        categoryCollectionView = CategoryCollectionView(frame: CGRect(x: 0, y: 0, width: frame.width, height: frame.height), collectionViewLayout: UICollectionViewFlowLayout())
        categoryCollectionView.setCollectionViewLayout(numberOfCells: numberOfCells)
        return categoryCollectionView
    }
    
    public func appendCollectionView() {
        self.addSubview(categoryCollectionView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
