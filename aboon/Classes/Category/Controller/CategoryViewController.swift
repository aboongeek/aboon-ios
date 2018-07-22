//
//  CategoryViewController.swift
//  aboon
//
//  Created by 原口和音 on 2018/06/23.
//  Copyright © 2018 aboon. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources

class CategoryViewController: UIViewController {
    
    let disposeBag = DisposeBag()
    
    lazy var model = CategoryCollectionModel()
    lazy var dataSource = CategoryCollectionViewDataSource()
    
    var categoryCollectionView: CategoryCollectionView!
    
    override func loadView() {
        self.view = CategoryView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let categoryView = (self.view as! CategoryView)
        
        self.navigationItem.configureBarItems(title: "カテゴリー", navigationController: navigationController as! NavigationController)
        
        categoryCollectionView = categoryView.initializeCollectionView()
        categoryView.appendCollectionView()

        categoryCollectionView.register(CategoryCollectionViewCell.self, forCellWithReuseIdentifier: "CategoryCell")
        
        Observable
            .combineLatest(model.categories, model.imageRelay) {CategoryCollectionViewDataSource.Element(items: $0, images: $1)}
            .bind(to: categoryCollectionView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
        
        dataSource
            .categoryObservable
            .subscribe(onNext: { (categoryName) in                
                let couponListViewController = CouponListViewController(withTitle: categoryName)
                couponListViewController.hidesBottomBarWhenPushed = true
                self.navigationController?.pushViewController(couponListViewController, animated: true)
            })
            .disposed(by: disposeBag)
        
        categoryCollectionView.delegate = dataSource
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

class CategoryCollectionViewDataSource: NSObject, UICollectionViewDataSource, RxCollectionViewDataSourceType, UICollectionViewDelegate {
    
    //RxCollectionViewDataSourceType
    struct Element {
        let items: [Category]
        let images: [String : UIImage]
    }
    
    var items = [Category]()
    var images = [String : UIImage]()
    
    func collectionView(_ collectionView: UICollectionView, observedEvent: Event<CategoryCollectionViewDataSource.Element>) {
        if case .next(let element) = observedEvent {
            items = element.items
            images = element.images
            collectionView.reloadData()
            (collectionView as! CategoryCollectionView).setCollectionViewLayout(numberOfCells: items.count)
        }
    }
    
    //UICollectionViewDataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoryCell", for: indexPath) as! CategoryCollectionViewCell
        cell.textLabel?.text = items[indexPath.row].categoryName
        cell.backGroundImageView?.image = images[items[indexPath.row].imagePath]
        return cell
    }
    
    //UICollectionViewDelegate
    private let selectedCategory = PublishSubject<String>()
    var categoryObservable: Observable<String> {return selectedCategory}
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedCategory.onNext(items[indexPath.row].categoryName)
    }
    
}
