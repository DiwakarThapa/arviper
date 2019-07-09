//
//  CouponListApiService.swift
//  GetSetGoJQCoin
//
//  Created by rozan on 4/17/19.
//  Copyright © 2019 ekbana. All rights reserved.
//

import Foundation
import Alamofire
protocol CouponApiService: ApiServiceType, RealmPersistenceType{
    func fetchCoupon(model:LocationStructure,success: @escaping ([CouponModel]) -> (), failure: @escaping (Error) -> () )
}

extension CouponApiService{
    
    func fetchCoupon(model:LocationStructure,success: @escaping ([CouponModel]) -> (), failure: @escaping (Error) -> () ) {
//        self.apiManager.refresh(success: {
            let url = Configuration.conf.baseURL + "/coupons"
            
            let param:[String:Any] = [
                "lat":model.latitude ?? 0,
                "lon":model.longitute ?? 0
            ]
            
            self.apiManager.genericApiRequest(url: url, method: .get, parameters: param, encoding: URLEncoding.default, header: nil, completion: { (model: CouponListModel) in
                //deleting old values
                let oldModels: [CouponRealmModel] = self.fetch()
                self.delete(models: oldModels)
                
                //saving currently fetched values
                let models = model.data.map({$0.realmModel()})
                self.save(models: models)
                success(model.data)
                
            }) { (error) in
                failure(error)
            }
            
//        }) { (error) in
//            failure(error)
//        }
        
    }
    
}
