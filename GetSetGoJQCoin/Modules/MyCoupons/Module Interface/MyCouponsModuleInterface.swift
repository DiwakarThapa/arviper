//
//  MyCouponsModuleInterface.swift
//  GetSetGoJQCoin
//
//  Created by rozan on 4/29/19.
//Copyright © 2019 ekbana. All rights reserved.
//

protocol MyCouponsModuleInterface: class {
    func fetchMyCoupon(sortType:String)
    func couponDetails(id:String)
    func refreshMycoupon()
//    func fetchActiveCoupons()
//    func fetchExpiredCoupons()
//    func fetchRedeemedCoupons()
}


