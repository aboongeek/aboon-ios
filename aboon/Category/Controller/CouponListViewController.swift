//
//  CouponListViewController.swift
//  aboon
//
//  Created by 原口和音 on 2018/06/24.
//  Copyright © 2018 aboon. All rights reserved.
//

import UIKit

class CouponListViewController: UIViewController {
    
    let model = CouponListCollectionModel()
    
    private let titleName: String = ""
    
    override func loadView() {
        self.view = CouponListView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = titleName
        self.view.backgroundColor = .white
        
        let couponListCollectionView = (self.view as! CouponListView).createCollectionView()
        couponListCollectionView.register(CouponListCollectionViewCell.self, forCellWithReuseIdentifier: "CouponListCollectionCell")
        
        couponListCollectionView.delegate = self
        couponListCollectionView.dataSource = model as UICollectionViewDataSource
        (self.view as! CouponListView).appendCollectionView(couponListCollectionView)
        
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

extension CouponListViewController: UICollectionViewDelegate{
    
}
