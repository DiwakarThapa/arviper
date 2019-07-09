//
//  CouponDetailsServiceType.swift
//  GetSetGoJQCoin
//
//  Created by rozan on 5/2/19.
//Copyright © 2019 ekbana. All rights reserved.
//

import Foundation

protocol CouponDetailsServiceType: class, ReedemCouponApiService {
    func fetchMyCouponDetails(id:String) -> MycouponsRealmModel
}

extension CouponDetailsServiceType {
    
    func fetchMyCouponDetails(id:String) -> MycouponsRealmModel{
        
        let models: [MycouponsRealmModel] = self.fetch()
        for index in 0 ..< models.map({$0.normalModel()}).count {
            if models[index].id == id {
                return models[index]
            }
        }
        return MycouponsRealmModel()
    }
    
}
