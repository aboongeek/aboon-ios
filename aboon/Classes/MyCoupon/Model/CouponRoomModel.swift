 //
//  CouponRoomModel.swift
//  aboon
//
//  Created by 原口和音 on 2018/08/12.
//  Copyright © 2018年 aboon. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import RxSwift
import RxCocoa

class CouponRoomModel {
    
    let disposeBag = DisposeBag()
    
    let roomsRef = Firestore.firestore().collection("rooms")
    let usersRef = Firestore.firestore().collection("users")
    
    lazy var user = Auth.auth().currentUser
    
    private let membersRelay = BehaviorRelay<[Member]>(value: [Member]())
    var members: Observable<[Member]> { return membersRelay.asObservable() }
    
    private let minimumCheckRelay = BehaviorRelay<(Bool, Int)>(value: (false, 0))
    var minimumCheck: Observable<(Bool, Int)> { return minimumCheckRelay.asObservable() }
    
    private let itemsToBeSharedSubject = ReplaySubject<[Any]>.create(bufferSize: 1)
    var itemsToBeShared: Observable<[Any]> { return itemsToBeSharedSubject.asObservable() }
    
    private let couponSubject = PublishSubject<Coupon>()
    var couponObservable: Observable<Coupon> { return couponSubject.asObservable() }
    
    private let couponImageSubject = PublishSubject<UIImage>()
    var couponImageObservable: Observable<UIImage> { return couponImageSubject.asObservable() }
    
    var roomId: String? = nil
    
    var coupon: Coupon? = nil
    
    var handle: AuthStateDidChangeListenerHandle?
    
    init(coupon: Coupon) {
        self.coupon = coupon
        
        subscribeMembers()
        membersRelay.accept([Member]())
    }
    
    init(withRoomId roomId: String, coupon: Coupon) {
        self.roomId = roomId
        self.coupon = coupon
        
        subscribeMembers()
        fetchMembers(isInvited: false)
    }
    
    init(withJustRoomId roomId: String) {
        self.roomId = roomId
        
        subscribeMembers()
        fetchMembers(isInvited: true)
    }
    
    func setUserListner() {
        self.handle = Auth.auth().addStateDidChangeListener { (auth, user) in
            self.user = user
        }
    }
    
    func removeUserListner() {
        Auth.auth().removeStateDidChangeListener(self.handle!)
    }
    
    private func fetchMembers(isInvited: Bool) {
        guard let roomId = roomId else { return }
        roomsRef.document(roomId).collection("members").order(by: "addedAt").getDocuments { [weak self] (snapshot, error) in
            guard let `self` = self, let snapshot = snapshot else { return }
            
            let members = snapshot.documents.map { document -> Member in
                let data = document.data()
                let userName = data["userName"] as! String
                let userId = data["userId"] as! String
                return Member(userName: userName, userId: userId)
            }
            
            self.membersRelay.accept(members)
            
            if isInvited {
                self.fetchCoupon(userId: members[0].userId, roomId: self.roomId!)
            }
        }
    }
    
    private func subscribeMembers() {
        self
            .members
            .subscribe(onNext: { [weak self] members in
                guard let `self` = self else { return }
                self.checkIfAvailable(members: members)
            })
            .disposed(by: disposeBag)
    }
    
    func createRoom(by member: Member) {
        
        let roomDoc = roomsRef.document()
        
        let docId = roomDoc.documentID
        self.roomId = docId
        
        roomDoc.setData(["isAvailable"  : false,
                         "isUsed"       : false,
                         "createdAt"    : Date()]) { error in
                            if let error = error {
                                dLog((error as NSError).userInfo)
                            }
        }
        
        addMember(member: member, isOwner: true)
    }
    
    func addMember(member: Member, isOwner: Bool) {
        guard let roomId = roomId else { return }
        let membersRef = roomsRef.document(roomId).collection("members")
        membersRef.addDocument(data: ["userId" : member.userId,
                                      "userName" : member.userName,
                                      "isOwner" : isOwner,
                                      "addedAt" : Date()]) { error in
                                        if let error = error {
                                            dLog(error as NSError)
                                        }
        }
        
        updateMyCoupon(userId: member.userId, completion: { [weak self] in
            guard let `self` = self else { return }
            var newMembers = self.membersRelay.value
            newMembers.append(member)
            self.membersRelay.accept(newMembers)
        })
    }
    
    func generateShareItems() {
        guard let user = user, let roomId = roomId else { return }
        guard let link = URL(string: "https://www.aboon.jp/?roomid=\(roomId)") else { return }
        
        let dynamicLinkDomain = "aboonapp.page.link"
        let linkBuilder = DynamicLinkComponents(link: link, domain: dynamicLinkDomain)
        linkBuilder.iOSParameters = DynamicLinkIOSParameters(bundleID: "jp.aboon.aboonApp")
        linkBuilder.iOSParameters?.appStoreID = "1424181262"
        linkBuilder.navigationInfoParameters = DynamicLinkNavigationInfoParameters()
        //linkBuilder.navigationInfoParameters?.isForcedRedirectEnabled = true
        linkBuilder.socialMetaTagParameters = DynamicLinkSocialMetaTagParameters()
        linkBuilder.socialMetaTagParameters?.title = "aboon"
        linkBuilder.socialMetaTagParameters?.descriptionText = "二人から始まるクーポンアプリ"
        linkBuilder.socialMetaTagParameters?.imageURL = URL(string: "https://firebasestorage.googleapis.com/v0/b/aboon-f68b2.appspot.com/o/SocialMetaImage%2Faboon_invitation.png?alt=media&token=c5987ece-bf73-4426-94ce-e62cd0df666e")
        
        guard let longDynamicLink = linkBuilder.url else { return }
        
        DynamicLinkComponents.shortenURL(longDynamicLink, options: nil) { [weak self] url, warnings, error in
            guard let `self` = self, let url = url, let coupon = self.coupon else { return }
            let userName = user.displayName!
            let invitationText = "\(userName)さんから、aboonのクーポン「\(coupon.name)」への招待が届いています。"
            
            let activityItems = [url, invitationText] as [Any]
            self.itemsToBeSharedSubject.onNext(activityItems)
        }
    }
    
    private func updateMyCoupon(userId: String, completion: @escaping ()->()) {
        guard let coupon = self.coupon else {
            return
        }
        guard let roomId = self.roomId else {
            return
        }
        
        let myCouponRef = usersRef.document(userId).collection("myCoupons").document(roomId)
        myCouponRef.setData([
            "name"          : coupon.name,
            "imagePath"     : coupon.imagePath,
            "description"   : coupon.description,
            "minimum"       : coupon.minimum,
            "shopId"        : coupon.shopId,
            "shopName"      : coupon.shopName,
            "isAvailable"   : false,
            "isUsed"        : false,
            "addedAt"       : Date()
        ]) { error in
            if let error = error {
                dLog((error as NSError).userInfo)
            } else {
                completion()
                dLog("a room has been created successfully!")
            }
        }
    }
    
    
    private func checkIfAvailable(members: [Member]) {
        guard let coupon = self.coupon, let roomId = self.roomId else { return }
        let isAvailable = members.count >= coupon.minimum
        minimumCheckRelay.accept((isAvailable, members.count))
        if isAvailable {
            members.forEach { (member) in
                let myCouponRef = usersRef.document(member.userId).collection("myCoupons").document(roomId)
                myCouponRef.setData(["isAvailable" : true], merge: true)
            }
        }
    }
    
    func fetchCoupon(userId: String, roomId: String) {
        let docRef = Firestore.firestore().collection("users").document(userId).collection("myCoupons").document(roomId)
        docRef.getDocument { [weak self] (document, error) in
            guard let `self` = self else {
                return
            }
            guard let document = document else {
                return
            }
            guard let data = document.data() else {
                return                
            }
            let name = data["name"] as! String
            let imagePath = data["imagePath"] as! String
            let description = data["description"] as! String
            let minimum = data["minimum"] as! Int
            let shopId = data["shopId"] as! Int
            let shopName = data["shopName"] as! String
            
            let coupon = Coupon(imagePath: imagePath, name: name, description: description, minimum: minimum, shopId: shopId, shopName: shopName)
            self.couponSubject.onNext(coupon)
            self.coupon = coupon
            self.fetchImage(ofShopId: shopId, withPath: imagePath)
        }
    }
    
    func fetchImage(ofShopId shopId: Int, withPath imagePath: String) {
        let imageRef = Storage.storage().reference(withPath: "CouponImages").child(shopId.description).child(imagePath)
        imageRef.getData(maxSize: 1 * 2048 * 2048) { [weak self] (data, error) in
            guard let `self` = self, let data = data, let image = UIImage(data: data) else { return }
            self.couponImageSubject.onNext(image)
            self.couponImageSubject.onCompleted()
        }
    }
}
