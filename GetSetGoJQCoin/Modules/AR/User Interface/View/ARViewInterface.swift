//
//  ARViewInterface.swift
//  GetSetGoJQCoin
//
//  Created by rozan on 4/19/19.
//Copyright © 2019 ekbana. All rights reserved.
//

protocol ARViewInterface: class {
    func couponData(model:[CouponViewModel])
    func show(error: Error)
    func showLoading()
    func hideLoading()
    func successCoupon(id:String)
    func couponClaimSuccess(model:CouponClaimedViewModel)
    func loadNextCoupon()

}
