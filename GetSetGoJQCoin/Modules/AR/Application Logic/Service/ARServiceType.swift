//
//  ARServiceType.swift
//  GetSetGoJQCoin
//
//  Created by rozan on 4/19/19.
//Copyright © 2019 ekbana. All rights reserved.
//

import Foundation

protocol ARServiceType: class,CouponValidationApiService , CouponClaimApiService{
    
    func fetchCupons() -> [CouponModel]
    func invalidate(couponId:String)
    
}

extension ARServiceType {
    
    func fetchCupons() -> [CouponModel] {
        let models: [CouponRealmModel] = self.fetch()
        return models.map({$0.normalModel()})
    }
    
    func invalidate(couponId:String){
        if let coupon:CouponRealmModel = self.fetch(primaryKey: couponId){
        let normorModel = coupon.normalModel()
            normorModel.isValid = false
            self.save(models:[normorModel.realmModel()])
        }
    }
    
}
