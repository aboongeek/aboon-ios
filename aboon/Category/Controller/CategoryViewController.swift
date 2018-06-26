//
//  CategoryViewController.swift
//  aboon
//
//  Created by 原口和音 on 2018/06/23.
//  Copyright © 2018 aboon. All rights reserved.
//

import UIKit

class CategoryViewController: UIViewController, UICollectionViewDelegate {
    
    let categoryView = CategoryCollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewLayout())
    
    override func loadView() {
        self.view = categoryView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let model = CategoryCollectionModel()
        categoryView.dataSource = model
        categoryView.delegate = self
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
}
