//
//  CouponClaimApiService.swift
//  GetSetGoJQCoin
//
//  Created by rozan on 4/26/19.
//  Copyright © 2019 ekbana. All rights reserved.
//

import Foundation
import Alamofire

protocol CouponClaimApiService: ApiServiceType, RealmPersistenceType{
    func claimCoupon(couponId:String,success: @escaping (CouponClaimData) -> (), failure: @escaping (Error) -> () )
}

extension CouponClaimApiService{
    
    func claimCoupon(couponId:String,success: @escaping (CouponClaimData) -> (), failure: @escaping (Error) -> () ) {
//        self.apiManager.refresh(success: {
            let url = Configuration.conf.baseURL + "/coupons/\(couponId)/claim"
            
            self.apiManager.genericApiRequest(url: url, method: .post, parameters: nil, encoding: JSONEncoding.default, header: nil, completion: { (model: CouponClaimModel) in
                if model.status == "success" && model.code == 200{
                    if let data = model.data {
                        let models = model.data?.realmModel()
                        self.save(models: [models ?? MycouponsRealmModel()])
                        success(data)
                    }
                }
            }) { (error) in
                failure(error)
            }
        
//        }) { (error) in
//            failure(error)
//        }
        
    }
    
}
