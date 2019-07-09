//
//  CouponDetailsViewInterface.swift
//  GetSetGoJQCoin
//
//  Created by rozan on 5/2/19.
//Copyright © 2019 ekbana. All rights reserved.
//

protocol CouponDetailsViewInterface: class {
    func showLoading()
    func hideLoading()
    func show(error:Error)
    func success(model:CouponDetailsViewModel)
    func success(message:String)
    
}
