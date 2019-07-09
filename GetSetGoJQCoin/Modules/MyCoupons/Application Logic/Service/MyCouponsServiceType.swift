//
//  MyCouponsServiceType.swift
//  GetSetGoJQCoin
//
//  Created by rozan on 4/29/19.
//Copyright © 2019 ekbana. All rights reserved.
//

import Foundation

protocol MyCouponsServiceType: class , MyCouponsApiService {
    func fetchMyCupons() -> [MyCouponsData] 
}
extension MyCouponsServiceType{
    func fetchMyCupons() -> [MyCouponsData] {
        let models: [MycouponsRealmModel] = self.fetch()
        return models.map({$0.normalModel()})
    }
}
