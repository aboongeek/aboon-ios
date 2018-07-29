//
//  NewCouponListViewController.swift
//  aboon
//
//  Created by EXIST on 2018/07/29.
//  Copyright © 2018年 aboon. All rights reserved.
//

import UIKit

class NewCouponListViewController: UIViewController {
    
    let model = NewCouponListCollectionModel()
    
    //navname
    private var titleName = String()
    
    init(withTitle: String) {
        self.titleName = withTitle
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func loadView() {
        self.view = NewCouponListView()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = titleName
        self.view.backgroundColor = UIColor(hex: "F5F5F5", alpha: 1.0)
        
        let newCouponlistCollectionView = (self.view as! NewCouponListView).createCollectionView()
        
        newCouponlistCollectionView.register(NewCouponListCollectionViewCell.self, forCellWithReuseIdentifier: "NewCouponListCollectionViewCell")
        
        newCouponlistCollectionView.delegate = self
        newCouponlistCollectionView.dataSource = model as! UICollectionViewDataSource
        (self.view as! NewCouponListView).appendCollectionView(newCouponlistCollectionView)
    }
}
    extension NewCouponListViewController: UICollectionViewDelegate{
        func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
            collectionView.deselectItem(at: indexPath, animated: true)
            dLog("selected:\(indexPath.row)")
            
    }
}
