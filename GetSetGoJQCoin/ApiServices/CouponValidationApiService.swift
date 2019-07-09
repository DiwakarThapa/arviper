//
//  CouponClaimApiService.swift
//  GetSetGoJQCoin
//
//  Created by rozan on 4/25/19.
//  Copyright © 2019 ekbana. All rights reserved.
//

import Foundation
import Alamofire

protocol CouponValidationApiService: ApiServiceType, RealmPersistenceType{
    func couponValidate(couponId:String,success: @escaping (Bool) -> (), failure: @escaping (Error) -> () )
}

extension CouponValidationApiService{

    
    func couponValidate(couponId:String,success: @escaping (Bool) -> (), failure: @escaping (Error) -> () ) {
        
//        self.apiManager.refresh(success: {
            let url = Configuration.conf.baseURL + "/coupons/\(couponId)/validate"
            self.apiManager.genericApiRequest(url: url, method: .post, parameters: nil, encoding: JSONEncoding.default, header: nil, completion: { (model: CouponValidateModel) in
                success(model.data?.isValid ?? false)
            }) { (error) in
                failure(error)
            }
//        }) { (error) in
//        failure(error)
//        }
    }
    
}
