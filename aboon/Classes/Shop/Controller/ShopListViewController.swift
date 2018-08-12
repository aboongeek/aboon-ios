//
//  ShopListViewController.swift
//  aboon
//
//  Created by 原口和音 on 2018/06/24.
//  Copyright © 2018 aboon. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources

class ShopListViewController: UIViewController {
    
    let disposeBag = DisposeBag()
    
    let model: ShopListCollectionModel
    lazy var dataSource = ShopListViewDataSource()
    
    private let titleName: String
    
    init(ofCategory category: Category) {
        self.model = ShopListCollectionModel(categoryPath: category.path)
        self.titleName = category.displayName

        super.init(nibName: nil, bundle: nil)
        
    }
    
    override func loadView() {
        self.view = ShopListView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let shopListView = self.view as! ShopListView
        
        self.navigationItem.title = titleName
        
        let shopListCollectionView = shopListView.initializeShopListView()
        shopListView.appendCollectionView()
        
        shopListCollectionView.register(ShopListCollectionViewCell.self, forCellWithReuseIdentifier: "ShopListCollectionCell")
        
        Observable
            .combineLatest(model.shopSummaries, model.images) {ShopListViewDataSource.Element(items: $0, images: $1)}
            .asDriver(onErrorDriveWith: Driver.empty())
            .drive(shopListCollectionView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
        
        dataSource
            .selectedShop
            .drive(onNext: { [weak self] (shop) in
                guard let `self` = self, let navigationController = self.navigationController else { return }
                let shopDetailViewController = ShopDetailViewController(ofShop: shop)
                navigationController.pushViewController(shopDetailViewController, animated: true)
            })
            .disposed(by: disposeBag)

        shopListCollectionView.delegate = dataSource
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

class ShopListViewDataSource: NSObject, UICollectionViewDataSource, RxCollectionViewDataSourceType, UICollectionViewDelegate {
   
    //RxCollectionViewDataSourceType
    struct Element {
        let items: [ShopSummary]
        let images: [String : UIImage]
    }
    
    var items = [ShopSummary]()
    var images = [String : UIImage]()
    
    func collectionView(_ collectionView: UICollectionView, observedEvent: Event<ShopListViewDataSource.Element>) {
        if case .next(let element) = observedEvent {
            items = element.items
            images = element.images
            collectionView.reloadData()
        }
    }
    
    //UICollectionViewDataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ShopListCollectionCell", for: indexPath) as! ShopListCollectionViewCell
        if let image = images[items[indexPath.row].imagePath] {
            cell.configure(text: items[indexPath.row].name, image: image)
        } else {
            cell.configure(text: items[indexPath.row].name, image: UIImage())
        }
        return cell
    }
    
    //UICollectionViewDelegate
    private let selectedShopSubject = PublishSubject<ShopSummary>()
    var selectedShop: Driver<ShopSummary> { return selectedShopSubject.asDriver(onErrorDriveWith: Driver.empty()) }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        
        selectedShopSubject.onNext(items[indexPath.row])
//        let shopDetailViewController = ShopDetailViewController(withTitle: model.shops[indexPath.row])
//        self.navigationController?.pushViewController(shopDetailViewController, animated: true)
    }
}

