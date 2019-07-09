//
//  DashboardServiceType.swift
//  GetSetGoJQCoin
//
//  Created by rozan on 5/9/19.
//Copyright © 2019 ekbana. All rights reserved.
//

import Foundation

protocol DashboardServiceType: class, CouponApiService, MyCouponsApiService, NotificationApiService {
     func fetchMyCupons() -> [MyCouponsData] 
}

extension DashboardServiceType {
    func fetchMyCupons() -> [MyCouponsData] {
        let models: [MycouponsRealmModel] = self.fetch()
        return models.map({$0.normalModel()})
    }
}
