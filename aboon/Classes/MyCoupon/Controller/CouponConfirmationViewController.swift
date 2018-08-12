//
//  CouponConfirmationViewController.swift
//  aboon
//
//  Created by 原口和音 on 2018/08/12.
//  Copyright © 2018年 aboon. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class CouponConfirmationViewController: UIViewController {

    let disposeBag = DisposeBag()
    
    let myCoupon: MyCoupon
    let image: UIImage
    
    lazy var couponConfirmationView = CouponConfirmationView()
    lazy var model = CouponConfirmationModel()
    
    init(myCoupon: MyCoupon, image: UIImage) {
        self.myCoupon = myCoupon
        self.image = image
        
        super.init(nibName: nil, bundle: nil)
    }
    
    override func loadView() {
        self.view = couponConfirmationView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        couponConfirmationView.configure(coupon: myCoupon, image: image)
        
        couponConfirmationView
            .useCouponPressed
            .subscribe(onNext: { [weak self] (isPressed) in
                guard let `self` = self else { return }
                if isPressed {
                    self.model.useCoupon(roomId: self.myCoupon.roomId)
                    self.dismiss(animated: true, completion: { [weak self] in
                        guard let `self` = self, let navigationController = self.navigationController else { return }
                        navigationController.popToRootViewController(animated: true)
                    })
                }
            })
            .disposed(by: disposeBag)
        
        couponConfirmationView
            .dismissPressed
            .subscribe(onNext: { [weak self] (isPressed) in
                guard let `self` = self else { return }
                if isPressed {
                    self.dismiss(animated: true, completion: nil)
                }
            })
            .disposed(by: disposeBag)
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
