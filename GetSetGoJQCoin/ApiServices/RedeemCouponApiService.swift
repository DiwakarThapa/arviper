//
//  RedeemCouponApiService.swift
//  GetSetGoJQCoin
//
//  Created by rozan on 5/2/19.
//  Copyright © 2019 ekbana. All rights reserved.
//

import Foundation
import Foundation
import Alamofire

protocol ReedemCouponApiService: ApiServiceType, RealmPersistenceType{
    func redeemCoupon(id:String,code:String,success: @escaping (String) -> (), failure: @escaping (Error) -> () )
}

extension ReedemCouponApiService{
    
    func redeemCoupon(id:String,code:String,success: @escaping (String) -> (), failure: @escaping (Error) -> () ) {
//        self.apiManager.refresh(success: {
            let url = Configuration.conf.baseURL + "/coupons/\(id)/redeem?shop_code=\(code)"
        
            self.apiManager.genericApiRequest(url: url, method: .post, parameters: nil, encoding: URLEncoding.default, header: nil, completion: { (model: CouponRedeemModel) in
                if let _ = model.data {
                    let models = model.data?.realmModel()
                    self.save(models: [models ?? MycouponsRealmModel()])
                    success(model.message ?? "")
                }
            }) { (error) in
                failure(error)
            }
//        }) { (error) in
//            failure(error)
//        }
       
    }
    
}
