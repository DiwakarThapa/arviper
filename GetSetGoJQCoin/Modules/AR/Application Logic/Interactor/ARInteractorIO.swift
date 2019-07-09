//
//  ARInteractorIO.swift
//  GetSetGoJQCoin
//
//  Created by rozan on 4/19/19.
//Copyright © 2019 ekbana. All rights reserved.
//

protocol ARInteractorInput: class {
    func claimCoupon(id:String)
    func getData()
    func validate(couponId:String)

}

protocol ARInteractorOutput: class {
    func obtained(message:String)
    func obtainedData(coupon:[CouponStructure])
    func obtained()
    func obtained(error:Error)
    func validated(couponId:String)
    func obtainedInvalidCoupon()
    func obtained(successCoupon:CouponClaimStructure)
   

}
