//
//  CouponListCollectionModel.swift
//  aboon
//
//  Created by John Titer on H30/06/30.
//  Copyright © 平成30年 aboon. All rights reserved.
//

import UIKit

class CouponListCollectionModel: NSObject {
    var sports = ["フットサル"]
    var cafeDining = ["俺のカフェ"]
    var beauty = ["髪の毛"]
    var relaxation = ["リラックスー"]
    var special = ["キラキラ"]
    var couple = ["きゃっきゃうふふ"]
    var coupons = ["coupon1", "coupon2"]
   
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

