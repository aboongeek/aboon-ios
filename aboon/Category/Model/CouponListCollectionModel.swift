//
//  CouponListCollectionModel.swift
//  aboon
//
//  Created by John Titer on H30/06/30.
//  Copyright © 平成30年 aboon. All rights reserved.
//

import UIKit

class CouponListCollectionModel: NSObject {
    var coupons = ["coupon1", "coupon2", "coupon3", "coupon4", "coupon5", "coupon6"]
    var details = ["a", "b", "c", "d", "e", "f"]
   
}
extension CouponListCollectionModel: UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return coupons.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CouponListCollectionCell", for: indexPath) as! CouponListCollectionViewCell
        cell.couponNameLabel?.text = coupons[indexPath.row]
        return cell
    }
}

