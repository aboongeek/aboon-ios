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

class CategoryViewController: UIViewController {
    
    var model: CategoryCollectionModel!
    var categoryCollectionView: CategoryCollectionView?
    
    override func loadView() {
        self.view = CategoryView()
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)

        model = CategoryCollectionModel()
        
        _ = model.fetchCategories()
            .observeOn(MainScheduler.instance)
            .subscribe(
                onNext: { (data) in
                    self.model.categories.append(data)
                    
                    _ = self.model.fetchCategoryImage(imagePath: data["imagePath"] as! String)
                        .observeOn(MainScheduler.instance)
                        .subscribe(
                            onNext: {(image, path) in
                                self.model.categoryImages.updateValue(image, forKey: path)
                                self.model.imageCount.accept(self.model.imageCount.value + 1)
                        }, onError: { (error) in
                            dLog("Error Loading Image: \(error)")
                        })
            },
                onError: { (error) in
                    dLog("Error Loading: \(error)")
            },
                onCompleted: {
                    self.categoriesDidLoad()
                    _ = self.model.imageCount
                        .subscribe(onNext: { (count) in
                            if count == self.model.categories.count {
                                self.imagesDidLoad()
                                dLog(self.model.categoryImages)
                            }
                        })
            })
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.configureBarItems(title: "カテゴリー", navigationController: navigationController as! NavigationController)
        
        (self.view as! CategoryView).setFrame(tabBar: (tabBarController?.tabBar)!, navBar: navigationController?.navigationBar as! NavigationBar)
        (self.view as! CategoryView).appendActivityIndicator()
    }
    
    func categoriesDidLoad() {
        categoryCollectionView = (self.view as! CategoryView).initializeCollectionView(numberOfCells: model.categories.count)
        categoryCollectionView?.register(CategoryCollectionViewCell.self, forCellWithReuseIdentifier: "CategoryCell")
        categoryCollectionView?.delegate = self
    }
    
    func imagesDidLoad() {
        categoryCollectionView?.dataSource = model
        (self.view as! CategoryView).appendCollectionView()
        (self.view as! CategoryView).stopActivityIndicator()
        (self.view as! CategoryView).setNeedsLayout()
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
