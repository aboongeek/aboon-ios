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
    
    let coupon: Coupon
    let roomId: String
    let image: UIImage
    
    lazy var couponConfirmationView = CouponConfirmationView()
    lazy var model = CouponConfirmationModel()
    
    init(coupon: Coupon, roomId: String, image: UIImage) {
        self.coupon = coupon
        self.roomId = roomId
        self.image = image
        
        super.init(nibName: nil, bundle: nil)
        
        self.modalPresentationStyle = .overCurrentContext
        
    }
    
    override func loadView() {
        self.view = couponConfirmationView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        couponConfirmationView.configure(coupon: coupon, image: image)
        
        couponConfirmationView
            .couponConfirmed
            .subscribe(onNext: { [weak self] (isPressed) in
                guard let `self` = self else { return }
                if isPressed {
                    self.model.useCoupon(roomId: self.roomId)
                    guard let presentingViewController = self.presentingViewController else {
                        return
                    }
                    
                    let confirmedAlert = UIAlertController(title: "完了", message: "クーポンが承認されました！aboonのまたのご利用をお待ちしております！", preferredStyle: .alert)
                    confirmedAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (_) in
                        self.dismiss(animated: true, completion: {
                            (presentingViewController as! NavigationController).popToRootViewController(animated: true)
                        })
                    }))
                    self.present(confirmedAlert, animated: true, completion: nil)
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
