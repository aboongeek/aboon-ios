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
        
        let categoryView = self.view as! CategoryView
        
        self.navigationItem.configureBarItems(title: "カテゴリー", navigationController: navigationController as! NavigationController)
        
        categoryCollectionView = categoryView.initializeCollectionView()
        categoryView.appendCollectionView()

        categoryCollectionView.register(CategoryCollectionViewCell.self, forCellWithReuseIdentifier: "CategoryCell")
        
        Observable
            .combineLatest(model.categories, model.images) {CategoryCollectionViewDataSource.Element(items: $0, images: $1)}
            .asDriver(onErrorDriveWith: Driver.empty())
            .drive(categoryCollectionView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
        
        dataSource
            .selectedCategory
            .drive(onNext: { [weak self] (category) in
                guard let `self` = self, let navigationController = self.navigationController else { return }
                let shopListViewController = ShopListViewController(ofCategory: category)
                navigationController.pushViewController(shopListViewController, animated: true)
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
        if let image = images[items[indexPath.row].imagePath] {
            cell.configure(text: items[indexPath.row].displayName, image: image)
        } else {
            cell.configure(text: items[indexPath.row].displayName, image: UIImage())
        }
        return cell
    }
    
    //UICollectionViewDelegate
    private let selectedCategorySubject = PublishSubject<Category>()
    var selectedCategory: Driver<Category> { return selectedCategorySubject.asDriver(onErrorDriveWith: Driver.empty()) }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedCategorySubject.onNext(items[indexPath.row])
    }
    
}
