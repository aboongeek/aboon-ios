//
//  CouponListViewController.swift
//  aboon
//
//  Created by 原口和音 on 2018/06/24.
//  Copyright © 2018 aboon. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources

class CouponListViewController: UIViewController {
    
    let disposeBag = DisposeBag()
    
    let model: CouponListCollectionModel
    lazy var dataSource = CouponListViewDataSource()
    
    private let titleName: String
    
    init(ofCategory category: Category) {
        model = CouponListCollectionModel(categoryPath: category.imagePath)
        self.titleName = category.categoryName

        super.init(nibName: nil, bundle: nil)
        
        self.hidesBottomBarWhenPushed = true
    }
    
    override func loadView() {
        self.view = CouponListView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let couponListView = self.view as! CouponListView
        
        self.navigationItem.title = titleName
        
        let couponListCollectionView = couponListView.initializeCouponListView()
        couponListView.appendCollectionView()
        
        couponListCollectionView.register(CouponListCollectionViewCell.self, forCellWithReuseIdentifier: "CouponListCollectionCell")
        
        Observable
            .combineLatest(model.shopSummaries, model.images) {CouponListViewDataSource.Element(items: $0, images: $1)}
            .asDriver(onErrorDriveWith: Driver.empty())
            .drive(couponListCollectionView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)

        couponListCollectionView.delegate = dataSource
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

class CouponListViewDataSource: NSObject, UICollectionViewDataSource, RxCollectionViewDataSourceType, UICollectionViewDelegate {
   
    //RxCollectionViewDataSourceType
    struct Element {
        let items: [ShopSummary]
        let images: [String : UIImage]
    }
    
    var items = [ShopSummary]()
    var images = [String : UIImage]()
    
    func collectionView(_ collectionView: UICollectionView, observedEvent: Event<CouponListViewDataSource.Element>) {
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
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CouponListCollectionCell", for: indexPath) as! CouponListCollectionViewCell
        if let image = images[items[indexPath.row].imagePath] {
            cell.configure(text: items[indexPath.row].name, image: image)
        } else {
            cell.configure(text: items[indexPath.row].name, image: UIImage())
        }
        return cell
    }
    
    //UICollectionViewDelegate
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        
//        let couponDetailViewController = CouponDetailViewController(withTitle: model.coupons[indexPath.row])
//        self.navigationController?.pushViewController(couponDetailViewController, animated: true)
    }
}

