//
//  CategoryViewController.swift
//  aboon
//
//  Created by 原口和音 on 2018/06/23.
//  Copyright © 2018 aboon. All rights reserved.
//

import UIKit

class CategoryViewController: UIViewController {
    
    let model = CategoryCollectionModel()
    
    override func loadView() {
        let categoryView = CategoryView()
        self.view = categoryView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.configureBarItems(title: "カテゴリー", navigationController: navigationController as! NavigationController)
        
        let categoryCollectionView = (self.view as! CategoryView).createCollectionView()
        categoryCollectionView.register(CategoryCollectionViewCell.self, forCellWithReuseIdentifier: "CategoryCell")
        
        categoryCollectionView.delegate = self
        categoryCollectionView.dataSource = model
        (self.view as! CategoryView).appendCollectionView(collectionView: categoryCollectionView)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
}

extension CategoryViewController: UICollectionViewDelegate {

}
