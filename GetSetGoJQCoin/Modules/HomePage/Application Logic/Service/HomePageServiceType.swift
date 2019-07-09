//
//  HomePageServiceType.swift
//  GetSetGoJQCoin
//
//  Created by rozan on 4/17/19.
//Copyright © 2019 ekbana. All rights reserved.
//

import Foundation

protocol HomePageServiceType: class , CouponApiService{
    func fetchCupons() -> [CouponModel]
    
}
protocol LogOutServiceType: RealmPersistenceType {
    func logout(success:@escaping() -> (), failure:@escaping(Error)-> ())
}

extension HomePageServiceType {
    func fetchCupons() -> [CouponModel] {
        let models: [CouponRealmModel] = self.fetch()
        return models.map({$0.normalModel()})
    }
}

extension LogOutServiceType{
    
    func logout(success:@escaping() -> (), failure:@escaping(Error)-> ()){
        self.deleteAll()
        success()
    }
    
   
    
}
