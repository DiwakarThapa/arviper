//
//  MyCouponsApiService.swift
//  GetSetGoJQCoin
//
//  Created by rozan on 4/30/19.
//  Copyright © 2019 ekbana. All rights reserved.
//

import Foundation
import Alamofire

protocol MyCouponsApiService: ApiServiceType, RealmPersistenceType{
    func fetchMyCoupons(success: @escaping ([MyCouponsData]) -> (), failure: @escaping (Error) -> () )
}

extension MyCouponsApiService{
    
    func fetchMyCoupons(success: @escaping ([MyCouponsData]) -> (), failure: @escaping (Error) -> () ) {
//        self.apiManager.refresh(success: {
            let url = Configuration.conf.baseURL + "/coupons/mycoupons"
            
            self.apiManager.genericApiRequest(url: url, method: .get, parameters: nil, encoding: URLEncoding.default, header: nil, completion: { (model: MyCouponsModel) in
                if let data = model.data {
                    
                    //deleting old values
                    let oldModels: [MycouponsRealmModel] = self.fetch()
                    self.delete(models: oldModels)
            
                    //saving currently fetched values
                    let models = model.data?.map({$0.realmModel()})
                    self.save(models: models ?? [])
                    success(data)
                }
            }) { (error) in
                failure(error)
            }
//        }) { (error) in
//        failure(error)
//        }
        
    }
    
    
  
}
