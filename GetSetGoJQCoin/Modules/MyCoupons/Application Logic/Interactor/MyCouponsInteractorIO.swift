//
//  MyCouponsInteractorIO.swift
//  GetSetGoJQCoin
//
//  Created by rozan on 4/29/19.
//Copyright © 2019 ekbana. All rights reserved.
//

protocol MyCouponsInteractorInput: class {
    func getMycoupon(sortBy:String)
    func fetchMycoupon()
//    func getExpiredCoupons()
//    func getRedeemedCooupons()
   
}

protocol MyCouponsInteractorOutput: class {
    func obtained(error:Error)
    func obtained(coupons:[MyCouponsStructure])
}
