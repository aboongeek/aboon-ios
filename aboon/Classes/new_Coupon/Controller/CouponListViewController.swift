//
//  CouponListViewController.swift
//  aboon
//
//  Created by EXIST on 2018/07/29.
//  Copyright © 2018年 aboon. All rights reserved.
//

import UIKit

class CouponListViewController: UIViewController {
    
    let model: CouponListCollectionModel
    
    //navname
    private var titleName = String()
    
    init(ofShop: Shop) {
        titleName = "クーポン"
        model = CouponListCollectionModel()
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func loadView() {
        self.view = CouponListView()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = titleName
        self.view.backgroundColor = UIColor(hex: "F5F5F5", alpha: 1.0)
        
        let newCouponlistCollectionView = (self.view as! CouponListView).createCollectionView()
        
        newCouponlistCollectionView.register(CouponListCollectionViewCell.self, forCellWithReuseIdentifier: "CouponListCollectionViewCell")
        
        newCouponlistCollectionView.delegate = self
        newCouponlistCollectionView.dataSource = model as! UICollectionViewDataSource
        (self.view as! CouponListView).appendCollectionView(newCouponlistCollectionView)
    }
}
    extension CouponListViewController: UICollectionViewDelegate{
        func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
            collectionView.deselectItem(at: indexPath, animated: true)
            dLog("selected:\(indexPath.row)")
            
            let couponDetailViewController = CouponDetailViewController(withTitle: model.titles[indexPath.row])
            self.navigationController?.pushViewController(couponDetailViewController, animated: true)
    }
}
