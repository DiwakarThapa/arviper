//
//  CouponDetailsInteractorIO.swift
//  GetSetGoJQCoin
//
//  Created by rozan on 5/2/19.
//Copyright © 2019 ekbana. All rights reserved.
//

protocol CouponDetailsInteractorInput: class {
    func getCouponDetails()
    func couponRedeem(id:String, code:String)
}

protocol CouponDetailsInteractorOutput: class {
    func obtained(error:Error)
    func obtained(message:String)
    func obtained(coupon:CoouponDetailsStructure)
}
