//
//  CouponDetailsInteractor.swift
//  GetSetGoJQCoin
//
//  Created by rozan on 5/2/19.
//Copyright © 2019 ekbana. All rights reserved.
//

import Foundation

class CouponDetailsInteractor {
    
	// MARK: Properties
    var couponId:String?
    weak var output: CouponDetailsInteractorOutput?
    private let service: CouponDetailsServiceType
    
    // MARK: Initialization
    
    init(service: CouponDetailsServiceType) {
        self.service = service
    }

    // MARK: Converting entities
    
    func convert(model:MycouponsRealmModel){
        var structure = CoouponDetailsStructure()
        structure.title = model.title
        structure.subtitle = model.subtitle
        structure.logo = model.logo
        structure.image = model.image
        structure.color = model.color
        structure.geoCoordinate = model.geoCoordinate
        structure.expiryDate = model.expiryDate
        structure.status = model.status
        structure.id = model.id
        structure.claimedDate = model.claimedDate
        structure.code = model.code
        structure.redeemedDate = model.redeemedDate
        structure.storeName = model.storeName
        structure.batchCode = model.batchCode
        
        self.output?.obtained(coupon: structure)
    }
    
}

// MARK: CouponDetails interactor input interface

extension CouponDetailsInteractor: CouponDetailsInteractorInput {
    
    func couponRedeem(id: String,  code:String) {
        self.service.redeemCoupon(id: id,code:code , success: { (success) in
            self.output?.obtained(message: success)
            
        }) { (error) in
            self.output?.obtained(error: error)
        }
    }
    
    
    func getCouponDetails() {
       let coupon = service.fetchMyCouponDetails(id: self.couponId ?? "")
        self.convert(model: coupon)
    }
    
    
    
}
