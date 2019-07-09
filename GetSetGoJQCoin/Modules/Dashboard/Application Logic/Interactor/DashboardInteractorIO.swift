//
//  DashboardInteractorIO.swift
//  GetSetGoJQCoin
//
//  Created by rozan on 5/9/19.
//Copyright © 2019 ekbana. All rights reserved.
//

protocol DashboardInteractorInput: class {
    func fetchNearestCoupons(location:LocationStructure)
    func fetchMyCoupons()
    func fetchCurrentNotification()
    func fetchMycouponFromRealm()
}

protocol DashboardInteractorOutput: class {
    func obtained(error:Error)
    func obtained(myCoupons:[DashboardMyCouponsStructure])
    func obtained(coupons:[DashboardCouponsStructure])
    func showNotification(status:Bool)
}
