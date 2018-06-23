//
//  CategoryViewController.swift
//  aboon
//
//  Created by 原口和音 on 2018/06/23.
//  Copyright © 2018 aboon. All rights reserved.
//

import UIKit

class CategoryViewController: UIViewController, UICollectionViewDelegate {

    private let categoryModel = CategoryModel()
    
    override func loadView() {
        self.view = CategoryView(model: categoryModel)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let categoryView = self.view as! CategoryView
        categoryView.categoryCollectionView.delegate = self
        categoryView.categoryCollectionView.dataSource = categoryModel
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
