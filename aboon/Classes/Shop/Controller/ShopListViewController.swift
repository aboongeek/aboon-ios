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
    
    lazy var shopListView = ShopListView()
    let model: ShopListCollectionModel
    lazy var dataSource = ShopListViewDataSource()
    
    let isBanner: Bool
    
    private let titleName: String
    
    init() {
        self.model = ShopListCollectionModel()
        self.titleName = "aboon"
        self.isBanner = true

        super.init(nibName: nil, bundle: nil)
        
    }
    
    init(of featured: Featured) {
        self.model = ShopListCollectionModel(of: featured.id)
        self.titleName = featured.name
        self.isBanner = false
        
        super.init(nibName: nil, bundle: nil)
    }
    
    override func loadView() {
        self.view = shopListView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.configureBarItems(title: titleName, navigationController: navigationController as! NavigationController)
        
        shopListView.appendViews()
        
        shopListView.shopListCollectionView.register(UINib(nibName: "ShopListCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ShopListCollectionViewCell")
        
        Observable
            .combineLatest(model.shopSummaries, model.shopImages) {ShopListViewDataSource.Element(items: $0, images: $1)}
            .asDriver(onErrorDriveWith: Driver.empty())
            .drive(shopListView.shopListCollectionView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
        
        dataSource
            .selectedShop
            .drive(onNext: { [weak self] (shop) in
                guard let `self` = self, let navigationController = self.navigationController else { return }
                let shopDetailViewController = ShopDetailViewController(ofShop: shop)
                navigationController.pushViewController(shopDetailViewController, animated: true)
            })
            .disposed(by: disposeBag)
        
        shopListView.shopListCollectionView.delegate = dataSource
        
        if isBanner {
            shopListView.bannerShown()
            
            guard let banner = shopListView.banner else { return }
            
            banner.scrollView.delegate = self
            
            model
                .featureds
                .asDriver(onErrorDriveWith: Driver.empty())
                .drive(onNext: { (featureds) in
                    banner.configure(featured: featureds)
                })
                .disposed(by: disposeBag)
            
            model
                .featuredImages
                .asDriver(onErrorDriveWith: Driver.empty())
                .drive(onNext: { (images) in
                    banner.addImages(images)
                })
                .disposed(by: disposeBag)
            
            banner
                .selectedItem
                .asDriver(onErrorDriveWith: Driver.empty())
                .drive(onNext: { [weak self] featured in
                    guard let `self` = self, let navigationController = self.navigationController else { return }
                    let shopListViewController = ShopListViewController(of: featured)
                    navigationController.pushViewController(shopListViewController, animated: true)
                })
                .disposed(by: disposeBag)
        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension ShopListViewController: UIScrollViewDelegate {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        guard let banner = shopListView.banner else { return }
            
        let currentPage = lround(Double(scrollView.contentOffset.x / scrollView.frame.width))
        
        banner.pageControl.currentPage = currentPage
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
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ShopListCollectionViewCell", for: indexPath) as! ShopListCollectionViewCell
        if let image = images[items[indexPath.row].imagePath] {
            cell.configure(shopName: items[indexPath.row].name, categoryName: items[indexPath.row].categoryName, image: image)
        } else {
            cell.configure(shopName: items[indexPath.row].name, categoryName: items[indexPath.row].categoryName, image: UIImage())
        }
        return cell
    }
    
    //UICollectionViewDelegate
    private let selectedShopSubject = PublishSubject<ShopSummary>()
    var selectedShop: Driver<ShopSummary> { return selectedShopSubject.asDriver(onErrorDriveWith: Driver.empty()) }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        
        selectedShopSubject.onNext(items[indexPath.row])
    }
}


