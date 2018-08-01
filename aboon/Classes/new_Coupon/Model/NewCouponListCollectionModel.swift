//
//  NewCouponListCollectionModel.swift
//  aboon
//
//  Created by EXIST on 2018/07/29.
//  Copyright © 2018年 aboon. All rights reserved.
//
import UIKit

class NewCouponListCollectionModel: NSObject {
    //test data
    var titles = ["coupon1", "coupon2", "coupon3", "coupon4", "coupon5", "coupon6"]
    var details = ["detailA", "detailB", "detailC", "detailD", "detailE", "detailF"]
    var couponImages = [R.image.number17(), R.image.number27(), R.image.number37(), R.image.number47(), R.image.number57(), R.image.number67()]
    var discounts =  ["10%\nOFF", "20%\nOFF", "30%\nOFF", "40%\nOFF", "50%\nOFF", "60%\nOFF"]
}

extension NewCouponListCollectionModel: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return titles.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NewCouponListCollectionViewCell", for: indexPath) as! NewCouponListCollectionViewCell
        cell.couponNameLabel?.text = titles[indexPath.row]
        cell.couponDetailLabel?.text = details[indexPath.row]
        cell.couponImageView?.image = couponImages[indexPath.row]
        cell.couponDiscountLabel?.text = discounts[indexPath.row]
        return cell
    }
    
}
