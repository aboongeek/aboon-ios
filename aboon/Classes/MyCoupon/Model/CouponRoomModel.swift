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
    
    let collectionRef = Firestore.firestore().collection("rooms")
    
    lazy var user = Auth.auth().currentUser
    
    private let membersRelay = BehaviorRelay<[Member]>(value: [Member]())
    var members: Observable<[Member]> { return membersRelay.asObservable() }
    
    private let minimumCheckSubject = PublishSubject<Bool>()
    var minimumCheck: Observable<Bool> { return minimumCheckSubject.asObservable() }
    
    var roomId: String? = nil
    
    let coupon: Coupon
    
    
    init(coupon: Coupon) {
        self.coupon = coupon
        
        membersRelay.accept([Member]())
        minimumCheckSubject.onNext(false)
        
    }
    
    init(withRoomId roomId: String, coupon: Coupon) {
        self.roomId = roomId
        self.coupon = coupon
        collectionRef.document(roomId).collection("members").getDocuments { [weak self] (snapshot, error) in
            guard let `self` = self, let snapshot = snapshot else { return }
            
            let members = snapshot.documents.map { document -> Member in
                let data = document.data()
                let userName = data["userName"] as! String
                let userId = data["userId"] as! String
                return Member(userName: userName, userId: userId)
            }
            
            self.membersRelay.accept(members)
            
            self.checkIfAvailable(members: members)
        }
    }
    
    
    func createRoom(by member: Member) {
        
        collectionRef.addDocument(data: ["isAvailable" : false,
                                         "isUsed" : false])
        
        let docId = collectionRef.document().documentID
        
        self.roomId = docId
        
        collectionRef.document(docId).collection("members").addDocument(data: ["userId" : member.userId,
                                                                               "userName" : member.userName])
        
        addToMyCoupon(userId: member.userId, coupon: coupon, roomId: docId)
        
        membersRelay.accept([member])
    }
    
    func addToMyCoupon(userId: String, coupon: Coupon, roomId: String) {
        Firestore.firestore().collection("users").document(userId).collection("myCoupons").addDocument(data: [
            "name"          : coupon.name,
            "imagePath"     : coupon.imagePath,
            "description"   : coupon.description,
            "minimum"       : coupon.minimum,
            "roomId"        : roomId,
            "isUsed"        : false
            ])
    }
    
    func addMember(member: Member) {
        guard let roomId = roomId else { return }
        collectionRef.document(roomId).collection("members").addDocument(data: ["userId" : member.userId,
                                                                                "userName" : member.userName])
        var newMembers = membersRelay.value
        newMembers.append(member)
        membersRelay.accept(newMembers)
        
        checkIfAvailable(members: newMembers)
    }
    
    
    func checkIfAvailable(members: [Member]) {
        if members.count >= coupon.minimum {
            minimumCheckSubject.onNext(true)
            members.forEach { (member) in
                Firestore.firestore().collection("users").document(member.userId).setData(["isAvailable" : true])
            }
        } else {
            minimumCheckSubject.onNext(false)
            members.forEach { (member) in
                Firestore.firestore().collection("users").document(member.userId).setData(["isAvailable" : false])
            }
        }
        
    }
    
    
}
