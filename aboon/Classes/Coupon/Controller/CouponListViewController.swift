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
    
    private var titleName = String()
    
    init(withTitle: String) {
        self.titleName = withTitle
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
        
        self.view.setFrame(navBar: navigationController?.navigationBar as! NavigationBar)
        self.navigationItem.title = titleName
        self.view.backgroundColor = UIColor(hex: "F5F5F5", alpha: 1.0)
        
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
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        
        let couponDetailViewController = CouponDetailViewController(withTitle: model.coupons[indexPath.row])
        self.navigationController?.pushViewController(couponDetailViewController, animated: true)
    }
}
