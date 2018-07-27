//
//  MyCouponListCollectionModel.swift
//  aboon
//
//  Created by EXIST on 2018/07/15.
//  Copyright © 2018年 aboon. All rights reserved.
//
//TODO:ルーム情報の追加
import UIKit

class MyCouponListCollectionModel: NSObject {
    //test data
    //データベースと仮定
    var coupons = ["coupon1", "coupon2", "coupon3", "coupon4", "coupon5", "coupon6"]
    var details = ["detailA", "detailB", "detailC", "detailD", "detailE", "detailF"]
    var couponImages = [R.image.airplaneSymbol7(), R.image.basketball7(), R.image.animalElement7(), R.image.albumSimple7(), R.image.bin7(), R.image.bookCoverTick7()]
    
    //data manage
    var couponlist: [TestCoupon] = []
    
    override init() {
        //TODO: for文を使わない方法で実装(遅いので)
        for index in 0..<coupons.count{
            let coupon = TestCoupon(name: coupons[index], detail: details[index], image: couponImages[index])
            couponlist.append(coupon)
        }
    }
}
extension MyCouponListCollectionModel: UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return coupons.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CouponListCollectionCell", for: indexPath) as! CouponListCollectionViewCell
        cell.couponNameLabel.text = couponlist[indexPath.row].name
//        cell.couponDetailLabel.text = couponlist[indexPath.row].detail
        cell.couponImageView.image = couponlist[indexPath.row].image
        return cell
    }
}
