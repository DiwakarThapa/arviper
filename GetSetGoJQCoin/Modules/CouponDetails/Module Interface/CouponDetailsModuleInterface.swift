//
//  CouponDetailsModuleInterface.swift
//  GetSetGoJQCoin
//
//  Created by rozan on 5/2/19.
//Copyright © 2019 ekbana. All rights reserved.
//

protocol CouponDetailsModuleInterface: class {
    func fetchCouponDetails()
    func couponRedeem(id:String, shopCode:String)
    func successPopup(message:String)
}

